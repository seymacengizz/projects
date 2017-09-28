//Þeyma Cengiz  1105011031
//Neslihan Hanecioglu 1105011017
//By State pattern and Singelton

//After the NoCoinState's insertCOin action,this state occurs.If the user eject the coin from machine
//then this state passes to NoCoinState.If the user select Cola this state passes to ColaSold state.
import java.util.Scanner;

public class HasCoinState implements State {
	private static ColaMachine colaMachine;

	private static HasCoinState instance;// We used singelton with state

	// pattern.It is one instance of this
	// class

	private HasCoinState() {

	}

	public static HasCoinState getInstance(ColaMachine m) {

		if (instance == null) {

			instance = new HasCoinState();
			colaMachine = m;

		}

		return instance;

	}

	@Override
	public void insertCoin() {
		System.out.println("You cannot insert any other coin!");

	}

	@Override
	public void ejectCoin() {
		System.out.println("Coin returned.");
		colaMachine.setState(colaMachine.getNoCoinState());

	}

	@Override
	public void refillMachine() {
		System.out.println("Already the machine has cola.");

	}

	@Override
	public void selectCola() {

		Scanner sc = new Scanner(System.in);
		System.out.println("Please enter selection item;");
		System.out.println("        [1]  for cap cola  \n"
				+ "        [2]  for 1 liter cola");
		int n1 = sc.nextInt();
		colaMachine.selection = n1;

		System.out.println("You selected .. ");
		colaMachine.setState(colaMachine.getColaSoldState());
				
	}

	@Override
	public void dispenseCola() {
		System.out.println("No cola dispensed");
	}

	@Override
	public void dispenseCoin() {
		System.out.println("No coin dispensed yet");

	}
}
