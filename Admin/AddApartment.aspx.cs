﻿using rwaLib.Dal;
using rwaLib.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin
{
    public partial class AddApartment : System.Web.UI.Page
    {
        private const string PATH_IMAGE = "./assets/apartments/";
        private const string PATH_IMAGE_MVC = @"C:\Users\Leo\Desktop\rwaApartments\WebApp\Admin\assets\apartments\";

        // APARTEMTNS
        private IList<ApartmentOwner> _listOfAllApartmentOwners;
        private IList<ApartmentStatus> _listOfAllApartmentStatuses;

        // TAGS CITIES
        private IList<City> _listAllCities;
        private IList<Tag> _listAllTags;

        protected void Page_Load(object sender, EventArgs e)
        {
            // LOAD ALL APARTMENTS TAGS AND CITIES

            _listOfAllApartmentOwners = ((IRepo)Application["database"]).LoadApartmentOwner();
            _listOfAllApartmentStatuses = ((IRepo)Application["database"]).LoadApartmentStatus();
            _listAllCities = ((IRepo)Application["database"]).LoadCity();
            _listAllTags = ((IRepo)Application["database"]).LoadTags();
            if (Session["user"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            if (!Page.IsPostBack)
            {
                AppendOwner();
                AppendStatus();
                AppendCity();
                AppendTags();
            }
        }

        private void AppendTags()
        {
            _listAllTags.ToList().ForEach(tag =>
            {
                ListItem tagItem = new ListItem(tag.Name, tag.Id.ToString());
                cblTag.Items.Add(tagItem);
            });
        }

        private void AppendCity()
        {
            ddlCity.DataSource = _listAllCities;
            ddlCity.DataValueField = "Id";
            ddlCity.DataTextField = "Name";
            ddlCity.DataBind();
        }

        private void AppendStatus()
        {
            ddlStatus.DataSource = _listOfAllApartmentStatuses;
            ddlStatus.DataValueField = "Id";
            ddlStatus.DataTextField = "Name";
            ddlStatus.DataBind();
        }

        private void AppendOwner()
        {
            ddlOwner.DataSource = _listOfAllApartmentOwners;
            ddlOwner.DataValueField = "Id";
            ddlOwner.DataTextField = "Name";
            ddlOwner.DataBind();
        }

        protected void addApartment_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Apartment a = new Apartment();
                a.Name = txtName.Text;
                a.NameEng = txtNameEng.Text;
                a.OwnerId = Int32.Parse(ddlOwner.SelectedItem.Value);
                a.TypeId = 999;
                a.StatusId = Int32.Parse(ddlStatus.SelectedItem.Value);
                a.CityId = Int32.Parse(ddlCity.SelectedItem.Value);
                a.Address = txtAddress.Text;
                a.Price = Decimal.Parse(txtPrice.Text);
                a.MaxAdults = Int32.Parse(txtMaxAdults.Text);
                a.MaxChildren = Int32.Parse(txtMaxChildren.Text);
                a.TotalRooms = Int32.Parse(txtTotalRooms.Text);
                a.BeachDistance = Int32.Parse(txtBeachDistance.Text);

                var apartmentId = ((IRepo)Application["database"]).AddApartment(a);

                if (apartmentId != 0)
                {
                    foreach (ListItem tagItem in cblTag.Items)
                    {
                        if (tagItem.Selected)
                        {
                            ((IRepo)Application["database"]).AddApartmentTag(new TaggedApartment(apartmentId, Int32.Parse(tagItem.Value)));
                        }

                        tagItem.Selected = false;
                    }

                    string mainPicture = Path.GetFileName(fuUploadMain.PostedFile.FileName);
                    string mainPictureNameOnly = Path.GetFileNameWithoutExtension(fuUploadMain.PostedFile.FileName);

                    string mainDirtPath = PATH_IMAGE + mainPicture;
                    string mainDirtPathMVC = PATH_IMAGE_MVC + mainPicture;

                    string mainFullPath = Server.MapPath(mainDirtPath);
                    string mainPictureBase64 = streamToBase64(fuUploadMain.PostedFile.InputStream);

                    fuUploadMain.SaveAs(mainFullPath);
                    fuUploadMain.SaveAs(mainDirtPathMVC);
                    ((IRepo)Application["database"]).AddApartmentPicture(new ApartmentPicture(apartmentId, mainDirtPath, mainPictureBase64, mainPictureNameOnly, true));

                    foreach (var file in fuUploadOther.PostedFiles)
                    {
                        string picture = Path.GetFileName(file.FileName);
                        string nameOnly = Path.GetFileNameWithoutExtension(file.FileName);
                        string dirPath = PATH_IMAGE + picture;
                        string dirPathMVC = PATH_IMAGE_MVC + picture;
                        string fullPath = Server.MapPath(dirPath);
                        string pictureBase64 = streamToBase64(file.InputStream);

                        fuUploadOther.SaveAs(fullPath);
                        fuUploadOther.SaveAs(dirPathMVC);

                        ((IRepo)Application["database"]).AddApartmentPicture(new ApartmentPicture(apartmentId, dirPath, pictureBase64, nameOnly, false));
                    }

                    fuUploadMain.Attributes.Clear();
                    fuUploadOther.Attributes.Clear();

                    PanelIspis.Visible = true;

                    txtName.Text = "";
                    txtNameEng.Text = "";
                    txtAddress.Text = "";
                    txtPrice.Text = "";
                    txtMaxAdults.Text = "";
                    txtMaxChildren.Text = "";
                    txtTotalRooms.Text = "";
                    txtBeachDistance.Text = "";
                }

            }
        }

        private string streamToBase64(Stream inputStream)
        {
            BinaryReader br = new BinaryReader(inputStream);
            Byte[] bytes = br.ReadBytes((Int32)inputStream.Length);
            return Convert.ToBase64String(bytes, 0, bytes.Length);
        }
    }
}