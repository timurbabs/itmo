using System;

namespace Banks
{
    public class ClientBuilder
    {
        private Client _client = new Client();

        public ClientBuilder()
        {
            this.Reset();
        }

        private void Reset()
        {
            this._client = new Client();
        }

        public ClientBuilder AddName(string first, string second)
        {
            this._client.Firstname = first;
            this._client.Lastname = second;
            return this;
        }

        public ClientBuilder AddAddress(string address)
        {
            this._client.Address = address;
            return this;
        }

        public ClientBuilder AddPassport(string passNum)
        {
            this._client.PassNum = passNum;
            return this;
        }

        public Client GetClient()
        {
            var result = this._client;
            if (this._client.Firstname == null && this._client.Lastname == null)
            {
                throw new Exception("Client don't have name.");
            }

            if (result.Address == null || result.PassNum == null)
            {
                result.Doubtful = false;
            }
            else
            {
                result.Doubtful = true;
            }

            this.Reset();
            return result;
        }
    }
}