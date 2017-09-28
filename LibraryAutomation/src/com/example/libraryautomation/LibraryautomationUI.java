package com.example.libraryautomation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.annotation.WebServlet;

import libraryprojebarrowtable.BorrowSubmit;
import libraryprojebarrowtable.BorrowTable;
import libraryprojebooktable.BookTable;
import libraryprojepersontable.PersonTable;

import com.vaadin.annotations.Theme;
import com.vaadin.annotations.VaadinServletConfiguration;
import com.vaadin.navigator.Navigator;
import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.server.ThemeResource;
import com.vaadin.server.VaadinRequest;
import com.vaadin.server.VaadinServlet;
import com.vaadin.shared.ui.button.ButtonServerRpc;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.FormLayout;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.NativeButton;
import com.vaadin.ui.Panel;
import com.vaadin.ui.PasswordField;
import com.vaadin.ui.TextField;
import com.vaadin.ui.UI;
import com.vaadin.ui.VerticalLayout;
@SuppressWarnings("serial")
@Theme("libraryautomation")
public class LibraryautomationUI extends UI {
	private VerticalLayout codeLayout;
	private VerticalLayout mainCodeLayout;
	private Statement ifade = null;
	 ResultSet sonucKumesi = null;
	 String y = null;
	 String g=null;
	 String y1=null;
		String g1=null;
	    protected static final String MAINVIEW = "main";
//	private MainPage mainPage;
	@WebServlet(value = "/*", asyncSupported = true)
	@VaadinServletConfiguration(productionMode = false, ui = LibraryautomationUI.class)
	public static class Servlet extends VaadinServlet {
	}

	@Override
	
	protected void init(VaadinRequest request) {
//	 mainPage = new MainPage();
		final VerticalLayout layout = new VerticalLayout();
		layout.setMargin(true);
		setContent(layout);
        layout.setStyleName("layout");
        layout.setStyleName("hVertical");
        layout.setMargin(false);
		mainCodeLayout = new VerticalLayout();
		mainCodeLayout.setSpacing(true);
		mainCodeLayout.setMargin(true);
		codeLayout = new VerticalLayout();
		codeLayout.setStyleName("codeLayout2");
        codeLayout.setWidth("400px");
 	   final AdminSubmit  submit=new AdminSubmit();
 	  final AdminSubmit submit1=new AdminSubmit();
 	 
 	
        final FormLayout form = new FormLayout();
        final VerticalLayout verForm= new VerticalLayout();
        final TextField username= new TextField("Username");
        final PasswordField password= new PasswordField("Password");
        Label label4 = null;
		 Label label5 = null;
        
        submit.getLabelUserName().setCaption((String) username.getValue());
   	  submit1.getLabelPassword().setCaption((String) password.getValue());
           
        NativeButton login = new NativeButton();
        login.setIcon(new ThemeResource("images/mainmenu/login.png"));
        login.setStyleName("login");
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
		
		try {
				sonucKumesi = ifade.executeQuery("SELECT * FROM Admin where adminID=1");
	
			while(sonucKumesi.next()){
				y=sonucKumesi.getString(1);
				g=sonucKumesi.getString(2);
			}
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		try {
			sonucKumesi = ifade.executeQuery("  Select * From Admin where adminID=2 ");
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		try {
			while(sonucKumesi.next()){
				y1=sonucKumesi.getString(1);
				g1=sonucKumesi.getString(2);
			}
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		

		
        form.setStyleName("formLogin");
        form.addComponent(username);
        form.addComponent(password);
        form.addComponent(login);
        verForm.addComponent(form);
       
        verForm.setComponentAlignment(form, Alignment.MIDDLE_CENTER);
    
       


        login.addClickListener(new Button.ClickListener() {
		
			@Override
			public void buttonClick(ClickEvent event) {
			   if(y.equals(username.getValue()) && g.equals(password.getValue()) || y1.equals(username.getValue()) && g1.equals(password.getValue()) ){
				// TODO Auto-generated method stub
			
				layout.removeAllComponents(); 
		NativeButton books = new NativeButton();
		NativeButton persons = new NativeButton();
		NativeButton borrows = new NativeButton();
		
		books.setIcon(new ThemeResource("images/mainmenu/books1.png"));
		persons.setIcon(new ThemeResource("images/mainmenu/persons11.png"));
		borrows.setIcon(new ThemeResource("images/mainmenu/barrows1.png"));
		books.setStyleName("books");
		persons.setStyleName("persons");
		borrows.setStyleName("borrows");
		
    final HorizontalLayout horButtons = new HorizontalLayout();
    final VerticalLayout   verBooks= new VerticalLayout();
    final VerticalLayout   verPersons= new VerticalLayout();
    final VerticalLayout   verBorrows= new VerticalLayout();
    final VerticalLayout verButtons= new VerticalLayout();
    
    Label labelBook= new Label("  Books");
    Label labelPerson= new Label("  Persons");
    Label labelBorrow= new Label("  Borrows");
    labelBook.setStyleName("labelBook");
    labelPerson.setStyleName("labelPerson");
    labelBorrow.setStyleName("labelBorrow");

    
    verButtons.setWidth("56px");
    verButtons.setHeight("800px");
    verBooks.setStyleName("verBooks");
    verButtons.setSizeFull();
    
    VerticalLayout hoverBook= new VerticalLayout();
    VerticalLayout hoverPerson= new VerticalLayout();		
    VerticalLayout hoverBorrow= new VerticalLayout();
    hoverBook.setStyleName("hoverBook");
    hoverPerson.setStyleName("hoverPerson");
    hoverBorrow.setStyleName("hoverBorrow");
    
    hoverBook.setWidth("95px");
    hoverPerson.setWidth("95px");
    hoverBorrow.setWidth("95px");
    
    hoverBook.setHeight("120px");
    hoverPerson.setHeight("120px");
    hoverBorrow.setHeight("120px");
    
    hoverBook.setSizeFull();
    hoverBook.addComponent(books);
    hoverBook.addComponent(labelBook);
    hoverBook.setComponentAlignment(labelBook, Alignment.TOP_CENTER);

    
    hoverPerson.setSizeFull();
    hoverPerson.addComponent(persons);
    hoverPerson.addComponent(labelPerson);
    hoverPerson.setComponentAlignment(labelPerson, Alignment.TOP_CENTER);

    hoverBorrow.setSizeFull();
    hoverBorrow.addComponent(borrows);
    hoverBorrow.addComponent(labelBorrow);
    hoverBorrow.setComponentAlignment(labelBorrow,Alignment.TOP_CENTER);
    
    verButtons.addComponent(hoverBook);
    verButtons.setComponentAlignment(hoverBook, Alignment.MIDDLE_LEFT);
    verButtons.addComponent(hoverPerson);
    verButtons.setComponentAlignment(hoverPerson, Alignment.MIDDLE_LEFT);
    verButtons.addComponent(hoverBorrow);
    verButtons.setComponentAlignment(hoverBorrow, Alignment.MIDDLE_LEFT);
		
    horButtons.addComponent(verButtons);
    try {
		BookTable book1= new BookTable(verBooks);
	} catch (UnsupportedOperationException | SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
    horButtons.setSpacing(true);
    horButtons.addComponent(verBooks);
//    horButtons.setComponentAlignment(verButtons, Alignment.MIDDLE_LEFT);
		BookTable book;
		PersonTable person;
		BorrowTable borrow;
		books.addClickListener(new Button.ClickListener() {
			public void buttonClick(ClickEvent event) {
			try {
				verBooks.removeAllComponents();
				verPersons.removeAllComponents();
				verBorrows.removeAllComponents();
	
				BookTable book = new BookTable(verBooks);
				horButtons.addComponent(verBooks);
		
			} catch (UnsupportedOperationException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
		});
		persons.addClickListener(new Button.ClickListener() {
			public void buttonClick(ClickEvent event) {
			try {
				verPersons.removeAllComponents();
			    verBooks.removeAllComponents();
			    verBorrows.removeAllComponents();

				PersonTable person = new PersonTable(verBooks);
				horButtons.addComponent(verPersons);
			} catch (UnsupportedOperationException | SQLException e) {
				e.printStackTrace();
			}
			}
		});
	
		borrows.addClickListener(new Button.ClickListener() {
			public void buttonClick(ClickEvent event) {
			try {
				verBorrows.removeAllComponents();
			    verPersons.removeAllComponents();
			    verBooks.removeAllComponents();
			

				BorrowTable borrow = new BorrowTable(verBorrows);
				horButtons.addComponent(verBorrows);
			
			} catch (UnsupportedOperationException | SQLException e) {
				e.printStackTrace();
			}
			}
		});
		layout.addComponent(horButtons);
		layout.setComponentAlignment(horButtons, Alignment.TOP_CENTER);
			}
			}
    	});
      
        VerticalLayout v = new VerticalLayout();
        v.setIcon(new ThemeResource("images/mainmenu/library1.png"));;
        mainCodeLayout.setSizeFull();
	    mainCodeLayout.setWidth("800px");
	    mainCodeLayout.setHeight("700px");
	    mainCodeLayout.setStyleName("mainLayout3");
	 
	    verForm.setStyleName("verForm");
	    mainCodeLayout.addComponent(v);
	    mainCodeLayout.setComponentAlignment(v, Alignment.TOP_LEFT);
	    codeLayout.addComponent(verForm);
	    codeLayout.setComponentAlignment(verForm, Alignment.MIDDLE_CENTER);

	   
		mainCodeLayout.addComponent(codeLayout);
		mainCodeLayout.setComponentAlignment(codeLayout,Alignment.TOP_CENTER);
		mainCodeLayout.setSpacing(true);
	
		layout.addComponent(mainCodeLayout);
		layout.setComponentAlignment(mainCodeLayout, Alignment.MIDDLE_CENTER);

}
	}
