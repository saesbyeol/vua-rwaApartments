using rwaLib.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace rwaLib.Dal
{
    public interface IRepo
    {
        // USER
        IList<User> LoadUsers();
        void AddUser(User user);
        void SaveUser (User user);

        // APARTMENT OWNER
        IList<ApartmentOwner> LoadApartmentOwner();
        IList<ApartmentStatus> LoadApartmentStatus();

        // CITY
        IList<City> LoadCity();

        // APARTMENT
        IList<Apartment> LoadApartments();
        int AddApartment (Apartment apt);
        void SaveApartment(Apartment apt);
        void DeleteAparatment (Apartment apt);

        // TAGS
        IList<Tag> LoadTags();
        IList<TagType> LoadTagTypes();
        void SaveTags(Tag tag);
        void DeleteTags(Tag tag);
        void AddTag(Tag tag);
        void AddApartmentTag(TaggedApartment tagged);
        void DeleteApartmentTagByApartmentId(int apartmentId);
        void DeleteApartmentImageById(int id);
        void AddApartmentPicture(ApartmentPicture apartmentPicture);
    }
}
