using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace rwaLib.Models
{
    [Serializable]
    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string PasswordHash { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }

        public User()
        {

        }
        public User(string username, string passwordHash)
        {
            Username = username;
            PasswordHash = passwordHash;
        }

        public User(string username, string passwordHash, string email, string phoneNumber, string address)
        {
            Username = username;
            PasswordHash = passwordHash;
            Email = email;
            PhoneNumber = phoneNumber;
            Address = address;
        }
    }
}
