using Saga.Network;
using Saga.Network.Packets;
using System;

namespace Saga.Packets
{
    /// <summary>
    ///
    /// </summary>
    /// <remarks>
    /// This packet is sent by the client to indicate he/she wants to
    /// delete a existing name on the friendlist. The client than waits for
    /// a valid response of SMSG_FRIENDLIST_UNREGISTER.
    ///
    /// Important: the packet is accociated with the characters name
    /// not a characters id and also the client allows you to sent
    /// empty names. The correct approach to handle this is to discard
    /// the packet without a response.
    /// </remarks>
    /// <id>
    /// 1202
    /// </id>
    internal class CMSG_FRIENDLIST_UNREGISTER : RelayPacket
    {
        public CMSG_FRIENDLIST_UNREGISTER()
        {
            this.data = new byte[32];
        }

        public string Name
        {
            get { return SpecialEncoding.Read(ref this.data, 0, 34).TrimEnd('\0'); }
        }

        #region Conversions

        public static explicit operator CMSG_FRIENDLIST_UNREGISTER(byte[] p)
        {
            /*
            // Creates a new byte with the length of data
            // plus 4. The first size bytes are used like
            // [PacketSize][PacketId][PacketBody]
            //
            // Where Packet Size equals the length of the
            // Packet body, Packet Identifier, Packet Size
            // Container.
            */

            CMSG_FRIENDLIST_UNREGISTER pkt = new CMSG_FRIENDLIST_UNREGISTER();
            pkt.data = new byte[p.Length - 14];
            pkt.session = BitConverter.ToUInt32(p, 2);
            Array.Copy(p, 6, pkt.cmd, 0, 2);
            Array.Copy(p, 12, pkt.id, 0, 2);
            Array.Copy(p, 14, pkt.data, 0, p.Length - 14);
            return pkt;
        }

        #endregion Conversions
    }
}