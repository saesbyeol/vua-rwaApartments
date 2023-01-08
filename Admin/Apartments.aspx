﻿<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Apartments.aspx.cs" Inherits="Admin.Apartments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="container p-4">
        <div class="row">
            <div class="col-sm-12">
                <asp:Repeater ID="rptApartments" runat="server">
                    <HeaderTemplate>
                        <table class="table" id="table_of_apartments">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Owner</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">City</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">NameEng</th>
                                    <th scope="col">Address</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">MaxAdults</th>
                                    <th scope="col">MaxChildren</th>
                                    <th scope="col">TotalRooms</th>
                                    <th scope="col">BeachDistance</th>
                                </tr>
                            </thead>
                            <tbody class="table_apartments">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <th scope="row"><%# Eval(nameof(rwaLib.Models.Apartment.Id)) %></th>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.OwnerName)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.Status)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.City)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.Name)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.NameEng)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.Address)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.Price)) %> HRK</td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.MaxAdults)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.MaxChildren)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.TotalRooms)) %></td>
                            <td><%# Eval(nameof(rwaLib.Models.Apartment.BeachDistance)) %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                    </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    <div class="container p-4">
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <fieldset class="p-4">
                        <legend>Select Apartment to Edit</legend>
                        <asp:ListBox runat="server"
                            ID="lbApartments"
                            CssClass="form-control"
                            AutoPostBack="true" OnSelectedIndexChanged="lbApartments_SelectedIndexChanged" />
                    </fieldset>
                </div>
                <div class="form-group">
                    <fieldset class="p-4">
                        <legend>Apartment image gallery</legend>
                        <asp:Repeater ID="repApartmentPictures" runat="server">
                            <ItemTemplate>
                                <div class="form-group">
                                    <div class="card mt-4">
                                      <asp:Image ID="imgApartmentPicture" runat="server" CssClass="card-img-top" ImageUrl='<%# Eval("Path")  %>' />
                                      <div class="card-body">
                                          <h5 class="card-title"><%# Eval("Name")  %></h5>
                                          <h6 class="card-subtitle mb-2 text-muted">
                                               <%# (bool)Eval("IsRepresentative") ?
                                                       "<span class='badge badge-pill bg-primary'>Primary image</span>" :
                                                       "" %>
                                          </h6>
                                          <asp:Button 
                                              ID="deleteImage" 
                                              class="btn btn-danger float-end" 
                                              runat="server"
                                              CausesValidation="False"
                                              CommandArgument='<%#Eval("Id")%>' 
                                              Text="Delete image"
                                              OnClick="deleteImage_Click" 
                                              />
                                      </div
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </fieldset>
                </div>
            </div>
            <div class="col-sm-6">
                <fieldset class="p-4">
                    <legend>Edit Apartment</legend>
                    <asp:Label ID="lblResult" runat="server" CssClass="alert alert-danger d-block w-100"></asp:Label>
                    <div class="mb-3">
                        <asp:Label ID="lblName" class="form-label" runat="server" Text="Name"></asp:Label>
                        <asp:TextBox ID="txtName" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtName" Display="Dynamic" ForeColor="Red">Niste upisali ime</asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblNameEng" class="form-label" runat="server" Text="NameEng"></asp:Label>
                        <asp:TextBox ID="txtNameEng" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtNameEng" Display="Dynamic" ForeColor="Red">Niste upisali ime na engleskom</asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblAddress" for="txtAddress" class="form-label" runat="server" Text="Address"></asp:Label>
                        <asp:TextBox ID="txtAddress" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAddress" Display="Dynamic" ForeColor="Red">Niste upisali adresu</asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblOwner" for="ddlOwner" class="form-label" runat="server" Text="Owner"></asp:Label>
                        <asp:DropDownList ID="ddlOwner" class="form-select" runat="server"></asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblStatus" for="ddlStatus" class="form-label" runat="server" Text="Status"></asp:Label>
                        <asp:DropDownList ID="ddlStatus" class="form-select" runat="server"></asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblCity" for="ddlCity" class="form-label" runat="server" Text="City"></asp:Label>
                        <asp:DropDownList ID="ddlCity" class="form-select" runat="server"></asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblTag" for="cblTag" class="form-label" runat="server" Text="Tag"></asp:Label>
                        <asp:CheckBoxList ID="cblTag" class="form-select table_tag" runat="server"></asp:CheckBoxList>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblPrice" for="txtPrice" class="form-label" runat="server" Text="Price"></asp:Label>
                        <asp:TextBox ID="txtPrice" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPrice" Display="Dynamic" ForeColor="Red">Niste upisali cijenu</asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblMaxAdults" for="txtMaxAdults" class="form-label" runat="server" Text="Max Adults"></asp:Label>
                        <asp:TextBox ID="txtMaxAdults" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtMaxAdults" Display="Dynamic" ForeColor="Red">Niste upisali broj odraslih osoba</asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblMaxChildren" for="txtMaxChildren" class="form-label" runat="server" Text="Max Children"></asp:Label>
                        <asp:TextBox ID="txtMaxChildren" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtMaxChildren" Display="Dynamic" ForeColor="Red">Niste upisali broj djece</asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblTotalRooms" for="txtTotalRooms" class="form-label" runat="server" Text="Total Rooms"></asp:Label>
                        <asp:TextBox ID="txtTotalRooms" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtTotalRooms" Display="Dynamic" ForeColor="Red">Niste upisali broj soba</asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblBeachDistance" for="txtBeachDistance" class="form-label" runat="server" Text="Beach Distance"></asp:Label>
                        <asp:TextBox ID="txtBeachDistance" class="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtBeachDistance" Display="Dynamic" ForeColor="Red">Niste upisali udaljenost od plaže</asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <asp:Label for="fuUploadMain" class="form-label" runat="server">Representative image</asp:Label>
                        <asp:FileUpload ID="fuUploadMain" runat="server" class="form-control" />
                        <asp:RequiredFieldValidator ID="validatorUploadMain" runat="server" ControlToValidate="fuUploadMain" Display="Dynamic" ForeColor="Red">Niste uploadli sliku</asp:RequiredFieldValidator>
                   </div>
                    <div class="mb-3">
                        <asp:Label for="fuUploadOther" class="form-label" runat="server">Other images</asp:Label>
                        <asp:FileUpload ID="fuUploadOther" multiple="multiple" runat="server" class="form-control" />
                        <asp:RequiredFieldValidator ID="validatorUploadOther" runat="server" ControlToValidate="fuUploadOther" Display="Dynamic" ForeColor="Red">Niste uplodali jos neku sliku</asp:RequiredFieldValidator>
                     </div>
                    <asp:Button ID="updateApartment" class="btn btn-primary" runat="server" Text="Update" OnClick="updateApartment_Click" />
                    <asp:Button ID="deleteApartment" class="btn btn-danger" runat="server" Text="Delete" OnClick="deleteApartment_Click" />
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>