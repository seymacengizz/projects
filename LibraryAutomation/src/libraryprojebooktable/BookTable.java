package libraryprojebooktable;

import java.awt.font.TextAttribute;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.vaadin.data.Property;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.server.ThemeResource;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.DateField;
import com.vaadin.ui.Form;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.NativeButton;
import com.vaadin.ui.Panel;
import com.vaadin.ui.Table;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

public class BookTable extends VerticalLayout implements View {
	private int countRow = 0;
	private Statement ifade = null;
	 ResultSet sonucKumesi = null;
		int 	i=0;
	 
	 private VerticalLayout verticalLayout;
		private VerticalLayout mainCodeLayout;
		private VerticalLayout codeLayout;

	@SuppressWarnings({ "deprecation", "deprecation", "deprecation" })
	public BookTable(final VerticalLayout h) throws UnsupportedOperationException, SQLException {
		
		h.setStyleName("hVertical");
		h.setMargin(false);
		Panel panel = new Panel();
//		panel.setWidth("100%");
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
		form.setCaption("Add the book");
        Form  form1=new Form();
        form1.setCaption("Update the book");
        form.setStyleName("formBook");
        form1.setStyleName("form1Book");
       HorizontalLayout hor=new HorizontalLayout();
  
       // *********************KÝTAP EKLEME**********************

        final TextField textName = new TextField("Book Name ");
		final TextField textISBN = new TextField("ISBN ");
		final TextField textNumber = new TextField("Page Number ");
		final DateField textDate = new DateField("Publishing Date ");
		final TextField textAuthor = new TextField("Author Name ");
		final TextField textAuthorLastName = new TextField("Author Last Name ");
		final TextField textCategory = new TextField("Category ");
		final TextField textBookID = new TextField("Book ID ");

		NativeButton buttonSave = new NativeButton();
	
		 buttonSave.setIcon(new ThemeResource("images/mainmenu/addBook111.png"));
		 buttonSave.setStyleName("addButton");
		  Connection con = null;
			try {
				con = DriverManager.getConnection
						  ( "jdbc:oracle:thin:@localhost:1521:XE", "YBUORCL","ybu123");
			} catch (SQLException e) {
				e.printStackTrace();
			}

			  
			 
			try {
				ifade = con.createStatement();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		
			sonucKumesi = ifade.executeQuery("  Select MAX(bookID) From Book");
			while(sonucKumesi.next()){
				String g=sonucKumesi.getString(1);
		i=Integer.parseInt(g);
			}
			
		final Table table = new Table();

		// Define two columns for the built-in container
		table.addContainerProperty("Book ID ", Label.class, null);
		table.addContainerProperty("Book Name ", Label.class, null);
		table.addContainerProperty("ISBN ", Label.class, null);
		table.addContainerProperty("PageNumber ", Label.class, null);
		table.addContainerProperty("PublishDate ", Label.class, null);
		table.addContainerProperty("AuthorName ", Label.class, null);
		table.addContainerProperty("AuthorLastName ", Label.class, null);
		table.addContainerProperty("Category ", Label.class, null);
		
		
			for(int k=1;k<=i;k++){
				sonucKumesi = ifade.executeQuery("SELECT * FROM Book where BookID='"+k+"'");
			while(sonucKumesi.next()){
				 Label labelID = null;
			 Label label = null;
			 Label label1 = null; 
			 Label label2 = null;
			 Label label3 = null;
			 Label label4 = null;
			 Label label5 = null;
			 Label label6 = null;
			try {
				labelID= new Label(sonucKumesi.getString(1));
				label = new Label(sonucKumesi.getString(2));
				label1 = new Label(sonucKumesi.getString(3));
				label2 = new Label(sonucKumesi.getString(4));
				label3 = new Label(sonucKumesi.getString(5));
			
			
			} catch (SQLException e) {
				e.printStackTrace();
			}
			sonucKumesi = ifade.executeQuery("  SELECT A.AuthorName,A.AuthorLastName,C.categoryName FROM Book  B, Author A,Category C"
					+ "  WHERE B.AuthorID = A.AuthorID AND BookID='"+k+"'"+" AND B.CategoryID=C.CategoryID");

			
			
			
			while(sonucKumesi.next()){
				
				label4 = new Label(sonucKumesi.getString(1));
				label5 = new Label(sonucKumesi.getString(2));
				label6=new Label(sonucKumesi.getString(3));
				}
				 table.addItem(new Object[] {labelID,label,label1,label2,label3,label4,label5,label6},k);
		}
			}
	
			buttonSave.addListener(new ClickListener() {
				@Override
				public void buttonClick(ClickEvent event) {
					
					   i++;
					   
					 BookSubmit submit=new BookSubmit();
					 BookSubmit submit1=new BookSubmit();
					 BookSubmit submit2=new BookSubmit();
					 BookSubmit submit3=new BookSubmit();
					 BookSubmit submit4=new BookSubmit();
					 BookSubmit submit5=new BookSubmit();
					 BookSubmit submit6=new BookSubmit();
					 BookSubmit submit7=new BookSubmit();
					 BookSubmit submit8=new BookSubmit();
				
					 submit.getLabelBookName().setCaption((String) textName.getValue());
					 submit1.getLabelISBN().setCaption((String) textISBN.getValue());
					 submit2.getLabelPageNumber().setCaption((String) textNumber.getValue());
					 submit3.getLabelPubDate().setCaption( textDate.getValue().toString());
					 submit4.getLabelAuthorName().setCaption((String) textAuthor.getValue());
					 submit5.getLabelAuthorLastName().setCaption((String) textAuthorLastName.getValue());
					 submit7.getLabelCategoryName().setCaption((String) textCategory.getValue());
					 submit8.getLabelBookID().setCaption((String) textBookID.getValue());
					
					 Label labelBookName = new Label(submit.getLabelBookName().getCaption());
					 Label labelAuthor   = new Label(submit1.getLabelISBN().getCaption());
					 Label labelNum      = new Label(submit2.getLabelPageNumber().getCaption());
					 Label labelPubDate      = new Label(submit3.getLabelPubDate().getCaption());
					 Label labelAuthorName      = new Label(submit4.getLabelAuthorName().getCaption());
					 Label labelAuthorLastName      = new Label(submit5.getLabelAuthorLastName().getCaption());
					 Label labelCategory      = new Label(submit7.getLabelCategoryName().getCaption());
					 String g=String.valueOf(i);
					 Label labelBookID      = new Label(g);
				
				table.addItem(new Object[]{labelBookID,labelBookName,labelAuthor,labelNum,labelPubDate,labelAuthorName,labelAuthorLastName,labelCategory},i);
				textName.setValue("");
				textISBN.setValue("");
				textNumber.setValue("");
				textDate.setValue(null);
				textAuthor.setValue("");
				textAuthorLastName.setValue("");
				textCategory.setValue("");
				
				
				
				try {
					
				
					
					 ifade.executeUpdate("insert into publishingHouse (publishingID) " +
								
					" values('"+i+"')");
				  
	            ifade.executeUpdate("insert into Category(categoryID,categoryName) " +
							
					" values('"+i+"','"+submit7.getLabelCategoryName().getCaption()+"')");
	            
	                ifade.executeUpdate("insert into Author(authorID,authorName,authorLastName) " +
							
					" values('"+i+"','"+submit4.getLabelAuthorName().getCaption()+"','"+submit5.getLabelAuthorLastName().getCaption()+"')");
	                
					ifade.executeUpdate("insert into Book(bookID,bookName,ISBN,NumberPage,publishinDate,authorID,categoryID,publishingID) " +
					" values('"+i+"','"+submit.getLabelBookName().getCaption()+"','"+submit1.getLabelISBN().getCaption()+"','"+
					submit2.getLabelPageNumber().getCaption()+"','"+submit3.getLabelPubDate().getCaption()+"','"+i+"','"+i+"','"+i+"')");
					}
				 catch (SQLException e) {
					e.printStackTrace();
				}
				
				countRow++;
			
				}
				
			});
			
			
		    form.getLayout().addComponent(textName);
		    form.getLayout().addComponent(textISBN);
		    form.getLayout().addComponent(textNumber);
		    form.getLayout().addComponent(textDate);
		    form.getLayout().addComponent(textAuthor);
		    form.getLayout().addComponent(textAuthorLastName);
		    form.getLayout().addComponent(textCategory);
		    form.getLayout().addComponent(buttonSave);
		    
	    
	 

		// *********************KÝTAP GÜNCELLEME**********************
		    final  TextField textBookID1 = new TextField("Book ID ");
		    final TextField textName1 = new TextField("Book Name ");
		    final TextField textISBN1= new TextField("ISBN ");
		    final TextField textNumber1 = new TextField("Page Number ");
		    final DateField textDate1 = new DateField("Publishing Date ");
		    final  TextField textAuthor1 = new TextField("Author Name ");
		    final  TextField textAuthorLastName1 = new TextField("Author Last Name ");
	
		    final BookSubmit submit11=new BookSubmit();
			 BookSubmit submit111=new BookSubmit();
			 BookSubmit submit22=new BookSubmit();
			 BookSubmit submit33=new BookSubmit();
			 BookSubmit submit44=new BookSubmit();
			 BookSubmit submit55=new BookSubmit();
			 BookSubmit submit66=new BookSubmit();
		       table.addListener(new Property.ValueChangeListener() {
					@Override
					public void valueChange(ValueChangeEvent event) {
						   submit11.setCaption( (String) table.getItem(3).getItemProperty(1).getValue());
						   textName1.setValue(""+submit11.getCaption());
					}
		    	});

	    NativeButton buttonSave1 = new NativeButton();
	    buttonSave1.setIcon(new ThemeResource("images/mainmenu/updateBook11.png"));
	    buttonSave1.setStyleName("updateButton");
		buttonSave1.addListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {
				   BookSubmit submit=new BookSubmit();
				 BookSubmit submit1=new BookSubmit();
				 BookSubmit submit2=new BookSubmit();
				 BookSubmit submit3=new BookSubmit();
				 BookSubmit submit4=new BookSubmit();
				 BookSubmit submit5=new BookSubmit();
				 BookSubmit submit6=new BookSubmit();
			
				 submit.getLabelBookName().setCaption((String) textName1.getValue());
				 submit1.getLabelISBN().setCaption((String) textISBN1.getValue());
				 submit2.getLabelPageNumber().setCaption((String) textNumber1.getValue());
				 submit3.getLabelPubDate().setCaption( textDate1.getValue().toString());
				 submit4.getLabelAuthorName().setCaption((String) textAuthor1.getValue());
				 submit5.getLabelAuthorLastName().setCaption((String) textAuthorLastName1.getValue());
				 submit6.getLabelBookID().setCaption((String) textBookID1.getValue());
				
				 Label labelBookName = new Label(submit.getLabelBookName().getCaption());
				 Label labelAuthor   = new Label(submit1.getLabelISBN().getCaption());
				 Label labelNum      = new Label(submit2.getLabelPageNumber().getCaption());
				 Label labelPubDate      = new Label(submit3.getLabelPubDate().getCaption());
				 Label labelAuthorName      = new Label(submit4.getLabelAuthorName().getCaption());
				 Label labelAuthorLastName      = new Label(submit5.getLabelAuthorLastName().getCaption());
				 Label labelBookID      = new Label(submit6.getLabelBookID().getCaption());
					int g=Integer.parseInt((submit6.getLabelBookID().getCaption()));
//					table.addItem(new Object[]{labelBookName,labelAuthor,labelNum,labelPubDate,labelAuthorName,labelAuthorLastName},i+2);
					table.addItem(new Object[]{labelBookName,labelAuthor,labelNum,labelPubDate,labelAuthorName,labelAuthorLastName},i);
			textBookID1.setValue("");
			textName1.setValue("");
			textISBN1.setValue("");
			textNumber1.setValue("");
			textDate1.setValue(null);
			textAuthor1.setValue("");
			textAuthorLastName1.setValue("");
			
		
			try {
			  
			
				String sorgu = "UPDATE Book  SET bookName= '" 
						  + submit.getLabelBookName().getCaption()+"', ISBN= '"+submit1.getLabelISBN().getCaption()
				            + "', NumberPage= '"+	submit2.getLabelPageNumber().getCaption()+"', publishinDate= '" 
				            +submit3.getLabelPubDate().getCaption()+"'where bookID="+g;
			        ifade.executeUpdate(sorgu); 
			        
				
			        String sorgu1 = "UPDATE Author SET authorName= '" 
							  + submit4.getLabelAuthorName().getCaption()+ "', authorLastName= '"
			    			+submit5.getLabelAuthorLastName().getCaption()+"'where authorID="+g;
				        ifade.executeUpdate(sorgu1); 
			        
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
			}
			
		});

		
	    form1.getLayout().addComponent(textBookID1);
		    form1.getLayout().addComponent(textName1);
		    form1.getLayout().addComponent(textISBN1);
		    form1.getLayout().addComponent(textNumber1);
		    form1.getLayout().addComponent(textDate1);
		    form1.getLayout().addComponent(textAuthor1);
		    form1.getLayout().addComponent(textAuthorLastName1);
	
		    
		    
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
		    mainCodeLayout.setStyleName("mainLayout");
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

	@Override
	public void enter(ViewChangeEvent event) {
		// TODO Auto-generated method stub
		
	}
}