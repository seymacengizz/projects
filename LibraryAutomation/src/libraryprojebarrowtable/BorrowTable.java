	package libraryprojebarrowtable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

import libraryprojebooktable.BookSubmit;

import com.google.gwt.canvas.dom.client.Context2d.TextBaseline;
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

public class BorrowTable extends VerticalLayout{
	private int countRow = 0;
	private Statement ifade = null;
	 ResultSet sonucKumesi = null;
	 int i;
	 private VerticalLayout verticalLayout;
		private VerticalLayout mainCodeLayout;
		private VerticalLayout codeLayout;

	@SuppressWarnings({ "deprecation", "deprecation", "deprecation" })
	public BorrowTable(final VerticalLayout h) throws UnsupportedOperationException, SQLException {
	
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
		form.setCaption("Add the borrow");
        Form  form1=new Form();
        form1.setCaption("Update the borrow");
        form.setStyleName("formBorrow");
        form1.setStyleName("form1Borrow");
      
       HorizontalLayout hor=new HorizontalLayout();
 
       
       //barrow adding

		final TextField textPersonName = new TextField("Person  Name ");
		final TextField textBookName = new TextField("Book Name ");
//		final TextField textDeadline = new TextField("Deadline ");
		final DateField textDeadline = new DateField("Deadline ");
//		final TextField textBorrowDate = new TextField("Borrow Date");
		final DateField textBorrowDate = new DateField("Borrow Date");
		final TextField textBorrowID = new TextField("Borrow ýd");
		final TextField textBookID = new TextField("book ýd");
		final TextField textPersonID = new TextField("person ýd");
		

		NativeButton buttonSave = new NativeButton();
		buttonSave.setIcon(new ThemeResource("images/mainmenu/Addborrow.png"));
		 buttonSave.setStyleName("addBorrow");
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
		
			sonucKumesi = ifade.executeQuery("  Select MAX(BarrowID) From Barrow");
			while(sonucKumesi.next()){
				String g=sonucKumesi.getString(1);
		i=Integer.parseInt(g);
			}
			
		final Table table = new Table();

		// Define two columns for the built-in container
		table.addContainerProperty("BorrowID ", Label.class, null);
		table.addContainerProperty("Deadline ", Label.class, null);
		table.addContainerProperty("Borrow Date ", Label.class, null);
		table.addContainerProperty("MemberName ", Label.class, null);
		table.addContainerProperty("BookName ", Label.class, null);
	
		
			for(int k=1;k<=i;k++){
				sonucKumesi = ifade.executeQuery("SELECT * FROM Barrow where BarrowID='"+k+"'");
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
				labelID = new Label(sonucKumesi.getString(1));
				label = new Label(sonucKumesi.getString(2));
				label1 = new Label(sonucKumesi.getString(3));
			
			
			
			} catch (SQLException e) {
				e.printStackTrace();
			}
			sonucKumesi = ifade.executeQuery("  SELECT M.MemberName,B.BookName  FROM member  M, Book B,Barrow b1"
					+ "  WHERE B.BookID ='"+k+"'"+"AND  M.MembershipID= '"+k+"'"+" AND b1.BarrowID= '"+k+"'");

			while(sonucKumesi.next()){
				
				label4 = new Label(sonucKumesi.getString(1));
				label5 = new Label(sonucKumesi.getString(2));
				}
				 table.addItem(new Object[] {labelID,label,label1,label4,label5},k);
		}
			}
	
		buttonSave.addListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {
				i++;
				   BorrowSubmit submit=new BorrowSubmit();
				   BorrowSubmit submit1=new BorrowSubmit();
				   BorrowSubmit submit2=new BorrowSubmit();
				   BorrowSubmit submit3=new BorrowSubmit();
				   BorrowSubmit submit4=new BorrowSubmit();
				   BorrowSubmit submit5=new BorrowSubmit();
				   BorrowSubmit submit6=new BorrowSubmit();
				
			
				 submit.getLabelPersonName().setCaption((String) textPersonName.getValue());
				 submit1.getLabelBookName().setCaption((String) textBookName.getValue());
				 submit2.getLabelDeadLine().setCaption( textDeadline.getValue().toString());
				 submit3.getLabelBorrowDate().setCaption(textBorrowDate.getValue().toString());
				 submit4.getLabelBorrowID().setCaption((String) textBorrowID.getValue());
				 submit5.getLabelBookID().setCaption((String) textBookID.getValue());
				 submit6.getLabelMemberID().setCaption((String) textPersonID.getValue());
				
				 Label labelPersonName = new Label(submit.getLabelPersonName().getCaption());
				 Label labelBookName   = new Label(submit1.getLabelBookName().getCaption());
				 Label labelDeadLine      = new Label(submit2.getLabelDeadLine().getCaption());
				 Label labelBorrowDate     = new Label(submit3.getLabelBorrowDate().getCaption());
				 Label labelBookID      = new Label(submit5.getLabelBookID().getCaption());
				 Label labelMemberID     = new Label(submit6.getLabelMemberID().getCaption());
				 String g1=String.valueOf(i);
				 Label labelBorrowID      = new Label(g1);
			
			table.addItem(new Object[]{labelBorrowID,labelPersonName,labelBookName,labelDeadLine,labelBorrowDate},2);
			textPersonName.setValue("");
			textBookName.setValue("");
			textDeadline.setValue(null);
			textBorrowDate.setValue(null);

			
			
			int j ,l ;
			try {
		
				
				
				sonucKumesi = ifade.executeQuery(" SELECT bookID  FROM book  WHERE bookName='"+submit1.getLabelBookName().getCaption()+"'");
				
				while(sonucKumesi.next()){
					
					String c=sonucKumesi.getString(1);
//					String h=sonucKumesi.getString(2);
					j=Integer.parseInt(c);
//					l=Integer.parseInt(h);
					
			
				
sonucKumesi = ifade.executeQuery(" SELECT membershipID  FROM member  WHERE memberName='"+submit.getLabelPersonName().getCaption()+"'");
				
				while(sonucKumesi.next()){
					
					String c1=sonucKumesi.getString(1);
//					String h=sonucKumesi.getString(2);
					l=Integer.parseInt(c1);
//					l=Integer.parseInt(h);
					
				
				
//						sonucKumesi = ifade.executeQuery(" SELECT bookID,MEMBERSHIPID  FROM book b ,membership m  WHERE b.bookName='"+submit1.getLabelBookName().getCaption()+"'"
//								+"AND m.memberName='"+submit.getLabelPersonName().getCaption()+"'");
					
				
				
						
							
                ifade.executeUpdate("insert into Barrow(BARROWID,DEADLINE,BARROWDATE,MEMBERSHIPID,BOOKID)  " +
						
				" values('"+i+"','"+submit2.getLabelDeadLine().getCaption()+"','"+submit3.getLabelBorrowDate().getCaption()+"','"+l+"','"+j+"')");
                
           
			}
				}		}
					
			catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
			countRow++;
			
			}
			
		});
		
		
	    form.getLayout().addComponent(textPersonName);
	    form.getLayout().addComponent(textBookName);
	    form.getLayout().addComponent(textDeadline);
	    form.getLayout().addComponent(textBorrowDate);
      
 
	// *********************KÝTAP GÜNCELLEME**********************

		final TextField textPersonName1 = new TextField("Person  Name ");
		final TextField textBookName1 = new TextField("Book Name ");
		final DateField textDeadline1 = new DateField("Deadline ");
		final DateField textBorrowDate1 = new DateField("Borrow Date");
		final TextField textBorrowID1 = new TextField("Borrow ID");
	


		NativeButton buttonSave1 = new NativeButton();
		buttonSave1.setIcon(new ThemeResource("images/mainmenu/Updateborrow.png"));
		 buttonSave1.setStyleName("updateBorrow");
		buttonSave1.addListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {
				   BorrowSubmit submit=new BorrowSubmit();
				   BorrowSubmit submit1=new BorrowSubmit();
				   BorrowSubmit submit2=new BorrowSubmit();
				   BorrowSubmit submit3=new BorrowSubmit();
				   BorrowSubmit submit4=new BorrowSubmit();
				   BorrowSubmit submit5=new BorrowSubmit();
				   BorrowSubmit submit6=new BorrowSubmit();
				
			
				 submit.getLabelPersonName().setCaption((String) textPersonName1.getValue());
				 submit1.getLabelBookName().setCaption((String) textBookName1.getValue());
				 submit2.getLabelDeadLine().setCaption(textDeadline1.getValue().toString());
				 submit3.getLabelBorrowDate().setCaption(textBorrowDate1.getValue().toString());
				 submit5.getLabelBorrowID().setCaption((String) textBorrowID1.getValue());
				
				
				 Label labelPersonName = new Label(submit.getLabelPersonName().getCaption());
				 Label labelBookName   = new Label(submit1.getLabelBookName().getCaption());
				 Label labelDeadLine      = new Label(submit2.getLabelDeadLine().getCaption());
				 Label labelBorrowDate     = new Label(submit3.getLabelBorrowDate().getCaption());
				 Label labelBorrowID      = new Label(submit5.getLabelBorrowID().getCaption());
			
					int g=Integer.parseInt((submit5.getLabelBorrowID().getCaption()));
			
			table.addItem(new Object[]{labelPersonName,labelBookName,labelDeadLine,labelBorrowDate },countRow);
			textPersonName1.setValue("");
			textBookName1.setValue("");
			textDeadline1.setValue(null);
			textBorrowDate1.setValue(null);
			textBorrowID1.setValue("");
			
			
			
			
			
			try {
			  
			
				String sorgu = "UPDATE barrow  SET deadline= '" 
						  +	submit2.getLabelDeadLine().getCaption()+"', barrowDate= '" 
				            +submit3.getLabelBorrowDate().getCaption()+"'where barrowID="+g;
			        ifade.executeUpdate(sorgu); 
			        
				
				
				
				
			        
			        
			        
			        
			    
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
			}
			
		});
		
		
		
		
		NativeButton buttonDelete = new NativeButton("Deleting Borrow");
		buttonDelete.addListener(new ClickListener() {
			@Override
			public void buttonClick(ClickEvent event) {
				   BorrowSubmit submit=new BorrowSubmit();
				   BorrowSubmit submit1=new BorrowSubmit();
				   BorrowSubmit submit2=new BorrowSubmit();
				   BorrowSubmit submit3=new BorrowSubmit();
				   BorrowSubmit submit4=new BorrowSubmit();
				   BorrowSubmit submit5=new BorrowSubmit();
				   BorrowSubmit submit6=new BorrowSubmit();
				
			
				 submit.getLabelPersonName().setCaption((String) textPersonName1.getValue());
				 submit1.getLabelBookName().setCaption((String) textBookName1.getValue());
				 submit2.getLabelDeadLine().setCaption( textDeadline1.getValue().toString());
				 submit3.getLabelBorrowDate().setCaption(textBorrowDate1.getValue().toString());
				 submit5.getLabelBorrowID().setCaption((String) textBorrowID1.getValue());
				
				
				 Label labelPersonName = new Label(submit.getLabelPersonName().getCaption());
				 Label labelBookName   = new Label(submit1.getLabelBookName().getCaption());
				 Label labelDeadLine      = new Label(submit2.getLabelDeadLine().getCaption());
				 Label labelBarrowDate     = new Label(submit3.getLabelBorrowDate().getCaption());
				 Label labelBarrowID      = new Label(submit5.getLabelBorrowID().getCaption());
			
				 
//				 Label labelBookID      = new Label(submit6.getLabelBookID().getCaption());
//					int g=Integer.parseInt((submit6.getLabelBookID().getCaption()));
				 Label labelBorrowID   = new Label(submit5.getLabelBorrowID().getCaption());
					int g=Integer.parseInt((submit5.getLabelBorrowID().getCaption()));
			
//			table.addItem(new Object[]{labelPersonName,labelBookName,labelDeadLine,labelBarrowDate },countRow);
			textPersonName1.setValue("");
			textBookName1.setValue("");
			textDeadline1.setValue(null);
			textBorrowDate1.setValue(null);
			textBorrowID1.setValue("");
			
			
			
			
			
			try {
			  
			
				String sorgu = "Delete FROM  barrow  where barrowID="+g;
			        ifade.executeUpdate(sorgu); 
			        
				
				
				
				
			        
			        
			        
			        
			    
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
			}
			
		});
		
		

		
		
		
		
		
		
		
		
		 form1.getLayout().addComponent(textPersonName1);
		    form1.getLayout().addComponent(textBookName1);
		    form1.getLayout().addComponent(textDeadline1);
		    form1.getLayout().addComponent(textBorrowDate1);
		    form1.getLayout().addComponent(textBorrowID1);
		    
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
		    horButton.addComponent(buttonDelete);
		    horButton.setSpacing(true);
		    
		    table.setPageLength(table.size());
            table.setHeight("300px");
            table.setWidth("710px");
//		    codeLayout.setHeight("800px");
		    mainCodeLayout.setSizeFull();
		    mainCodeLayout.setWidth("800px");
		    mainCodeLayout.setStyleName("mainLayout2");
		    codeLayout.addComponent(hor);
			codeLayout.addComponent(horButton);
			
			mainCodeLayout.addComponent(codeLayout);
			mainCodeLayout.setComponentAlignment(codeLayout,Alignment.TOP_RIGHT);
			mainCodeLayout.setSpacing(true);
			//setComponentAlignment(mainCodeLayout, Alignment.MIDDLE_CENTER);	
			mainCodeLayout.addComponent(table);
			mainCodeLayout.setComponentAlignment(table, Alignment.MIDDLE_LEFT);
			
//			panel.setContent(mainCodeLayout);
			h.addComponent(mainCodeLayout);
			h.setComponentAlignment(mainCodeLayout, Alignment.TOP_CENTER);
		
	}

}

	



