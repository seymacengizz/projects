package libraryprojepersontable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.vaadin.server.ThemeResource;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.Form;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.NativeButton;
import com.vaadin.ui.OptionGroup;
import com.vaadin.ui.Panel;
import com.vaadin.ui.Table;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

public class PersonTable extends VerticalLayout{
	private int countRow = 0;
	private Statement ifade = null;
	 ResultSet sonucKumesi = null;
	 int i;
	 int a ;
	 private VerticalLayout verticalLayout;
		private VerticalLayout mainCodeLayout;
		private VerticalLayout codeLayout;
	@SuppressWarnings({ "deprecation", "deprecation", "deprecation" })
	public PersonTable(final VerticalLayout  h) throws UnsupportedOperationException, SQLException {
		h.setStyleName("hVertical");
		h.setMargin(false);
		Panel panel = new Panel();
		panel.setStyleName("panelstyle");
		panel.setHeight("900px");
		verticalLayout = new VerticalLayout();
		mainCodeLayout = new VerticalLayout();
		mainCodeLayout.setSpacing(true);
		mainCodeLayout.setMargin(true);
		codeLayout = new VerticalLayout();
		codeLayout.setStyleName("codeLayout");
		
//		mainCodeLayout.setWidth("550px");
//		mainCodeLayout.setHeight("200px");
        h.setStyleName("codeverticallayout");
		Form form = new Form();
		form.setCaption("Add the member");
       Form  form1=new Form();
       form1.setCaption("Update the member");
       form.setStyleName("formPerson");
       form1.setStyleName("form1Person");
      HorizontalLayout hor=new HorizontalLayout();
   
      
       //********person ekleme***************

		final TextField textName = new TextField("Member Name ");
		final TextField textLastName = new TextField("Member Last Name ");
		final TextField textPhoneNumber = new TextField("Phone Number ");
		final ComboBox gender= new ComboBox("Gender ");
		gender.addItems("girl", "boy");
		gender.setStyleName("gender");
		final TextField textEmail = new TextField("Member Email ");
		NativeButton buttonSave = new NativeButton("Add Member");
		buttonSave.setIcon(new ThemeResource("images/mainmenu/Addperson.png"));
		 buttonSave.setStyleName("addPerson");
		  Connection con = null;
			try {
				con = DriverManager.getConnection
						  ( "jdbc:oracle:thin:@localhost:1521:XE", "YBUORCL","ybu123");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			  
			 
			try {
				ifade = con.createStatement();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			sonucKumesi = ifade.executeQuery("  Select MAX(MEMBERSHIPID) From member");
			while(sonucKumesi.next()){
				String g=sonucKumesi.getString(1);
		i=Integer.parseInt(g);
			}
			
		final Table table = new Table();
	
		// Define two columns for the built-in container
		table.addContainerProperty("MemberID ", Label.class, null);
		table.addContainerProperty("Member Phone  ", Label.class, null);
		table.addContainerProperty("Member Name ", Label.class, null);
		table.addContainerProperty("Gender ", Label.class, null);
	
		table.addContainerProperty("Member Last Name ", Label.class, null);
		
		table.addContainerProperty("Email ", Label.class, null);
		table.addContainerProperty("County ", Label.class, null);
		table.addContainerProperty("Province ", Label.class, null);
		
		
		
			for(int k=1;k<=i;k++){
				sonucKumesi = ifade.executeQuery("SELECT * FROM MEMBER  where MEMBERSHIPID='"+k+"'");
			while(sonucKumesi.next()){
				Label labelID = null;
			 Label label = null;
			 Label label1 = null; 
			 Label label2 = null;
			 Label label3 = null;
			 Label label4 = null;
			 Label label5 = null;
			 Label label6 = null;
			 Label label7 = null;
			 Label label8 = null;
			try {
				labelID = new Label(sonucKumesi.getString(1));
				label = new Label(sonucKumesi.getString(2));
				label1 = new Label(sonucKumesi.getString(3));
				label2 = new Label(sonucKumesi.getString(4));
				label3 = new Label(sonucKumesi.getString(5));
				label4 = new Label(sonucKumesi.getString(6));
			
			
			} catch (SQLException e) {
				e.printStackTrace();
			}
	
			sonucKumesi = ifade.executeQuery("  SELECT A.County,A.Province  FROM Member B,Address  A"
					+ "  WHERE B.AddressID = A.AddressID  AND MEMBERSHIPID='"+k+"'");

			
			
			
			while(sonucKumesi.next()){
				
				label7 = new Label(sonucKumesi.getString(1));
				label8 = new Label(sonucKumesi.getString(2));
				}
				 table.addItem(new Object[] {labelID,label,label1,label2,label3,label4,label7,label8},k);
		}
			}
			
			
			
	
	
		buttonSave.addListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {
				i++;
				
				 PersonSubmit submit=new PersonSubmit();
				 PersonSubmit submit1=new PersonSubmit();
				 PersonSubmit submit2=new PersonSubmit();
				 PersonSubmit submit3=new PersonSubmit();
				 PersonSubmit submit4=new PersonSubmit();
				 
				 submit.getLabelName().setCaption((String) textName.getValue());
				 submit1.getLabelLastName().setCaption((String) textLastName.getValue());
				 submit2.getLabelPhoneNumber().setCaption((String) textPhoneNumber.getValue());
				 submit3.getLabelGender().setCaption(gender.getCaption());
				 submit4.getLabelEmail().setCaption((String) textEmail.getValue());
				 
				 String g1=(String) gender.getValue();
				 Label labelName = new Label(submit.getLabelName().getCaption());
				 Label labelLastName = new Label(submit1.getLabelLastName().getCaption());
				 Label labelPhoneNum = new Label(submit2.getLabelPhoneNumber().getCaption());
				 Label labelGender = new Label(g1 );
				
				 Label labelEmail = new Label(submit4.getLabelEmail().getCaption());
				 String g=String.valueOf(i);
				 Label labelID = new Label(g);
				 
				 
			table.addItem(new Object[]{labelID,labelName,labelLastName,labelPhoneNum,labelGender,labelEmail},i);
			textName.setValue("");
			textLastName.setValue("");
			textPhoneNumber.setValue("");
			gender.setValue(null);
			textEmail.setValue("");
			
			
			try {
				
		
			
				ifade.executeUpdate("insert into Address(adressID) " +
						" values('"+i+"')");
				
				ifade.executeUpdate("insert into member(membershipID,MemberName,memberLastName,phone,gender,email,ADDRESSID) " +
						" values('"+i+"','"
						+submit.getLabelName().getCaption()+"','"+submit1.getLabelLastName().getCaption()+submit2.getLabelPhoneNumber().getCaption()+"','"+
						submit3.getLabelGender().getCaption()+"','"+"','"+submit4.getLabelEmail().getCaption()+"','"+i+"')");
				
				
				
				
				
				}
			 catch (SQLException e) {
				e.printStackTrace();
			}
			
			countRow++;
		
			}
			
		});
		
		
	    form.getLayout().addComponent(textName);
	    form.getLayout().addComponent(textLastName);
	    form.getLayout().addComponent(textPhoneNumber);
	    form.getLayout().addComponent(gender);
	    form.getLayout().addComponent(textEmail);
	    form.getLayout().addComponent(buttonSave);
	    
	 

		// ******************UPDATE PERSON************************
	    final TextField textName1 = new TextField("Name ");
		final TextField textLastName1 = new TextField("Last Name ");
		final TextField textPhoneNumber1 = new TextField("Phone number ");
		final ComboBox gender1= new ComboBox("Gender ");
		gender1.addItems("girl", "boy");
		final TextField textEmail1 = new TextField("Email");
		  final  TextField textMemberID = new TextField("Member ID ");

		  NativeButton buttonSave1 = new NativeButton();
		    buttonSave1.setIcon(new ThemeResource("images/mainmenu/updateperson.png"));
		    buttonSave1.setStyleName("updateButton");
			buttonSave1.addListener(new ClickListener() {
				@Override
				public void buttonClick(ClickEvent event) {
					   PersonSubmit submit=new PersonSubmit();
					   PersonSubmit submit1=new PersonSubmit();
					   PersonSubmit submit2=new PersonSubmit();
					   PersonSubmit submit3=new PersonSubmit();
					   PersonSubmit submit4=new PersonSubmit();
					   PersonSubmit submit5=new PersonSubmit();
					   PersonSubmit submit6=new PersonSubmit();
				
					 submit.getLabelName().setCaption((String) textName1.getValue());
					 submit1.getLabelLastName().setCaption((String) textLastName1.getValue());
					 submit2.getLabelPhoneNumber().setCaption((String) textPhoneNumber1.getValue());
					 submit3.getLabelGender().setCaption( gender1.getCaption());
					 submit4.getLabelEmail().setCaption((String) textEmail1.getValue());
					 submit5.getLabelPersonID().setCaption((String) textMemberID.getValue());
					 String g11=(String) gender.getValue();
					 Label labelPersonName = new Label(submit.getLabelName().getCaption());
					 Label labelPersonLastName   = new Label(submit1.getLabelLastName().getCaption());
					 Label labelPhoneNumber      = new Label(submit2.getLabelPhoneNumber().getCaption());
					 Label labelGender     = new Label(g11);
					 Label labelLabelEmail    = new Label(submit4.getLabelEmail().getCaption());
					 Label labelPersonID      = new Label(submit5.getLabelPersonID().getCaption());
						int g=Integer.parseInt((submit5.getLabelPersonID().getCaption()));
//						table.addItem(new Object[]{labelBookName,labelAuthor,labelNum,labelPubDate,labelAuthorName,labelAuthorLastName},i+2);
						table.addItem(new Object[]{labelPhoneNumber,labelPersonName,labelGender,labelPersonLastName,labelLabelEmail},i);
						textName1.setValue("");
						textLastName1.setValue("");
						textPhoneNumber1.setValue("");
						textEmail1.setValue("");
						textMemberID.setValue("");
						gender1.setValue(null);
				
			
				try {
				  
				
					String sorgu = "UPDATE member  SET MEMBERNAME= '" 
							  + submit.getLabelName().getCaption()+"', PHONE= '"+submit2.getLabelPhoneNumber().getCaption()
					            + "', GENDER= '"+	submit3.getLabelGender().getCaption()+"', MEMBERLASTNAME= '" 
					            +submit1.getLabelLastName().getCaption()+"', EMAIL= '" +submit4.getLabelEmail().getCaption()+"'where membershipID="+g;
				        ifade.executeUpdate(sorgu); 
				        
					
				
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			
				}
				
			});
		    form1.getLayout().addComponent(textMemberID);
			 form1.getLayout().addComponent(textName1);
			    form1.getLayout().addComponent(textLastName1);
			    form1.getLayout().addComponent(textPhoneNumber1);
			    form1.getLayout().addComponent(gender1);
			    form1.getLayout().addComponent(textEmail1);
			
			    
			    
		    HorizontalLayout horButton=new HorizontalLayout();
		    hor.setSizeFull();
		    hor.setStyleName("formHorLayout");
		    hor.addComponent(form);
		    hor.setSpacing(true);
		    hor.setComponentAlignment(form, Alignment.TOP_LEFT);
		    hor.addComponent(form1);
		    hor.setComponentAlignment(form1, Alignment.TOP_RIGHT);
		    
		    horButton.setSizeFull();
		  
		    horButton.setStyleName("buttonHorLayout");
		    horButton.addComponent(buttonSave);
		    horButton.setComponentAlignment(buttonSave, Alignment.TOP_LEFT);
		    horButton.addComponent(buttonSave1);
		    horButton.setSpacing(true);
		    
		    table.setPageLength(table.size());
            table.setHeight("300px");
            table.setWidth("710px");
//		    codeLayout.setHeight("800px");
		    mainCodeLayout.setSizeFull();
		    mainCodeLayout.setWidth("800px");
		    mainCodeLayout.setStyleName("mainLayout1");
		    codeLayout.addComponent(hor);
			codeLayout.addComponent(horButton);
			
			mainCodeLayout.addComponent(codeLayout);
			mainCodeLayout.setComponentAlignment(codeLayout,Alignment.TOP_CENTER);
			mainCodeLayout.setSpacing(true);
			//setComponentAlignment(mainCodeLayout, Alignment.MIDDLE_CENTER);	
			mainCodeLayout.addComponent(table);
			mainCodeLayout.setComponentAlignment(table, Alignment.MIDDLE_LEFT);
			
//			panel.setContent(mainCodeLayout);
			h.addComponent(mainCodeLayout);
			h.setComponentAlignment(mainCodeLayout, Alignment.TOP_CENTER);
		
	}

}