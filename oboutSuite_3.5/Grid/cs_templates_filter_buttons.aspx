<%@ Page Language="C#"%>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script language="C#" runat="server">
    Grid grid1 = new Grid();
    
	void Page_load(object sender, EventArgs e)		
	{
        grid1.ID = "grid1";
        grid1.CallbackMode = true;
        grid1.Serialize = true;
        grid1.AutoGenerateColumns = false;
        
        grid1.FolderStyle = "styles/grand_gray";
        grid1.AllowAddingRecords = false;
        grid1.AllowFiltering = true;
        grid1.TemplateSettings.FilterShowButton_TemplateId = "tplShowFilter";
        grid1.TemplateSettings.FilterApplyButton_TemplateId = "tplApplyFilter";
        grid1.TemplateSettings.FilterHideButton_TemplateId = "tplHideFilter";
        grid1.TemplateSettings.FilterRemoveButton_TemplateId = "tplRemoveFilter";        


        // creating the Templates
        
        //------------------------------------------------------------------------
        GridRuntimeTemplate tplShowFilter = new GridRuntimeTemplate();
        tplShowFilter.ID = "tplShowFilter";
        tplShowFilter.Template = new Obout.Grid.RuntimeTemplate();
        tplShowFilter.Template.CreateTemplate += new Obout.Grid.GridRuntimeTemplateEventHandler(CreateShowFilterTemplate);
        //------------------------------------------------------------------------

        //------------------------------------------------------------------------
        GridRuntimeTemplate tplApplyFilter = new GridRuntimeTemplate();
        tplApplyFilter.ID = "tplApplyFilter";
        tplApplyFilter.Template = new Obout.Grid.RuntimeTemplate();
        tplApplyFilter.Template.CreateTemplate += new Obout.Grid.GridRuntimeTemplateEventHandler(CreateApplyFilterTemplate);
        //------------------------------------------------------------------------

        //------------------------------------------------------------------------
        GridRuntimeTemplate tplHideFilter = new GridRuntimeTemplate();
        tplHideFilter.ID = "tplHideFilter";
        tplHideFilter.Template = new Obout.Grid.RuntimeTemplate();
        tplHideFilter.Template.CreateTemplate += new Obout.Grid.GridRuntimeTemplateEventHandler(CreateHideFilterTemplate);
        //------------------------------------------------------------------------

        //------------------------------------------------------------------------
        GridRuntimeTemplate tplRemoveFilter = new GridRuntimeTemplate();
        tplRemoveFilter.ID = "tplRemoveFilter";
        tplRemoveFilter.Template = new Obout.Grid.RuntimeTemplate();
        tplRemoveFilter.Template.CreateTemplate += new Obout.Grid.GridRuntimeTemplateEventHandler(CreateRemoveFilterTemplate);
        //------------------------------------------------------------------------
        


        // adding the templates to the Templates collection
        grid1.Templates.Add(tplShowFilter);
        grid1.Templates.Add(tplApplyFilter);
        grid1.Templates.Add(tplHideFilter);
        grid1.Templates.Add(tplRemoveFilter);        

        																			
        // creating the columns
        Column oCol1 = new Column();
        oCol1.DataField = "SupplierID";
        oCol1.ReadOnly = true;
        oCol1.HeaderText = "ID";
        oCol1.Width = "60";
        oCol1.Visible = false;

        Column oCol2 = new Column();
        oCol2.DataField = "CompanyName";
        oCol2.HeaderText = "COMPANY NAME";
        oCol2.Width = "300";        

        Column oCol3 = new Column();
        oCol3.DataField = "Address";
        oCol3.HeaderText = "COMPANY ADDRESS";
        oCol3.Width = "250";        

        Column oCol4 = new Column();
        oCol4.DataField = "City";
        oCol4.HeaderText = "CITY";
        oCol4.Width = "200";        

        Column oCol5 = new Column();
        oCol5.DataField = "Country";
        oCol5.HeaderText = "COUNTRY";
        oCol5.Width = "125";       

        // add the columns to the Columns collection of the grid
        grid1.Columns.Add(oCol1);
        grid1.Columns.Add(oCol2);
        grid1.Columns.Add(oCol3);
        grid1.Columns.Add(oCol4);
        grid1.Columns.Add(oCol5);

        // add the grid to the controls collection of the PlaceHolder
        phGrid1.Controls.Add(grid1);        
        
		if (!Page.IsPostBack)
		{
			CreateGrid();			
		}
	}
    
    
    // Create the methods that will load the data into the templates
	//------------------------------------------------------------------------
    public void CreateShowFilterTemplate(Object sender, Obout.Grid.GridRuntimeTemplateEventArgs e)
	{
		Literal oLiteral = new Literal();	
		e.Container.Controls.Add(oLiteral);
        oLiteral.DataBinding += new EventHandler(DataBindShowFilterTemplate);
	}
    protected void DataBindShowFilterTemplate(Object sender, EventArgs e)
	{
		Literal oLiteral = sender as Literal;
		Obout.Grid.TemplateContainer oContainer = oLiteral.NamingContainer as Obout.Grid.TemplateContainer;

        oLiteral.Text = "<input type=\"button\" id=\"btnShowFilter\" class=\"tdTextSmall\" value=\"Show Filter\" onclick=\"grid1.showFilter()\"/>";
	}
	//------------------------------------------------------------------------

    //------------------------------------------------------------------------
    public void CreateApplyFilterTemplate(Object sender, Obout.Grid.GridRuntimeTemplateEventArgs e)
    {        
        Literal oLiteral = new Literal();
        e.Container.Controls.Add(oLiteral);
        oLiteral.DataBinding += new EventHandler(DataBindApplyFilterTemplate);
    }
    protected void DataBindApplyFilterTemplate(Object sender, EventArgs e)
    {
        Literal oLiteral = sender as Literal;
        Obout.Grid.TemplateContainer oContainer = oLiteral.NamingContainer as Obout.Grid.TemplateContainer;

        oLiteral.Text = "<input type=\"button\" id=\"btnApplyFilter\" class=\"tdTextSmall\" value=\"Apply Filter\" onclick=\"grid1.filter()\"/>";
    }
    //------------------------------------------------------------------------

    //------------------------------------------------------------------------
    public void CreateHideFilterTemplate(Object sender, Obout.Grid.GridRuntimeTemplateEventArgs e)
    {
        Literal oLiteral = new Literal();
        e.Container.Controls.Add(oLiteral);
        oLiteral.DataBinding += new EventHandler(DataBindHideFilterTemplate);
    }
    protected void DataBindHideFilterTemplate(Object sender, EventArgs e)
    {
        Literal oLiteral = sender as Literal;
        Obout.Grid.TemplateContainer oContainer = oLiteral.NamingContainer as Obout.Grid.TemplateContainer;

        oLiteral.Text = "<input type=\"button\" id=\"btnHideFilter\" class=\"tdTextSmall\" value=\"Hide Filter\" onclick=\"grid1.hideFilter()\"/>";
    }
    //------------------------------------------------------------------------

    //------------------------------------------------------------------------
    public void CreateRemoveFilterTemplate(Object sender, Obout.Grid.GridRuntimeTemplateEventArgs e)
    {
        Literal oLiteral = new Literal();
        e.Container.Controls.Add(oLiteral);
        oLiteral.DataBinding += new EventHandler(DataBindRemoveFilterTemplate);
    }
    protected void DataBindRemoveFilterTemplate(Object sender, EventArgs e)
    {
        Literal oLiteral = sender as Literal;
        Obout.Grid.TemplateContainer oContainer = oLiteral.NamingContainer as Obout.Grid.TemplateContainer;

        oLiteral.Text = "<input type=\"button\" id=\"btnRemoveFilter\" class=\"tdTextSmall\" value=\"Remove Filter\" onclick=\"grid1.removeFilter()\"/>";
    }
    //------------------------------------------------------------------------
    
	
	void CreateGrid()
	{
		OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"));

		OleDbCommand myComm = new OleDbCommand("SELECT * FROM Suppliers", myConn);
		myConn.Open();		
		OleDbDataReader myReader = myComm.ExecuteReader();

		grid1.DataSource = myReader;
		grid1.DataBind();

		myConn.Close();	
	}
	</script>		

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> <html>
	<head>
		<title>obout ASP.NET Grid examples</title>
		<style type="text/css">
			.tdText {
				font:11px Verdana;
				color:#333333;
			}
			.option2{
				font:11px Verdana;
				color:#0033cc;
				background-color___:#f6f9fc;
				padding-left:4px;
				padding-right:4px;
			}
			a {
				font:11px Verdana;
				color:#315686;
				text-decoration:underline;
			}

			a:hover {
				color:crimson;
			}
			.tdTextSmall {
	            font:9px Verdana;
	            color:#333333;
            }
		</style>		
	</head>
	<body>	
		<form runat="server">
					
		<br />
		<span class="tdText"><b>ASP.NET Grid - Templates for the "Show Filter"/"Apply Filter"/"Hide Filter"/"Remove Filter" buttons</b></span>
		<br /><br />			
		
		<asp:PlaceHolder ID="phGrid1" runat="server"></asp:PlaceHolder>				

		<br /><br /><br />
		
		<span class="tdText">		   
		    Use the <b>FilterShowButton_TemplateId</b>, <b>FilterApplyButton_TemplateId</b>, <b>FilterHideButton_TemplateId</b> and <b>FilterRemoveButton_TemplateId</b><br />
		    properties of the <b>Grid</b> class to specify the Templates for the "Show Filter"/"Apply Filter"/"Hide Filter"/"Remove Filter" buttons.
		</span>


		<br /><br /><br />
		
		<a href="Default.aspx?type=CSHARP">� Back to examples</a>
		
		</form>
	</body>
</html>