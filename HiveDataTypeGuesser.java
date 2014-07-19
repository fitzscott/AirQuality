package airQuality;

import java.io.IOException;
import java.util.Iterator;

import org.apache.pig.EvalFunc;
import org.apache.pig.PigWarning;
import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.DataBag;
import org.apache.pig.data.TupleFactory;

public class HiveDataTypeGuesser extends EvalFunc<Integer> {

	private static int DT_INTEGER = 1;
	private static int DT_DOUBLE = 2;
	//private static int DT_DATE = 3;
	private static int DT_STRING = 4;

	public static void main(String[] args) {
		System.out.println("Need to figure out how to test this.");
	}

	@Override
	public Integer exec(Tuple arg0) throws IOException {
		String maybeNumber = (String) arg0.get(0);
		return(guessType(maybeNumber));
	}

	static protected Integer guessType(String fld) {
		return(checkIntOrFloat(fld));
	}
	
	static protected Integer checkIntOrFloat(String fld) {
		Integer gTy = -1;
		int i = 0;
		boolean isNumeric = true;
		int decimalPtCnt = 0;
		char numch = ' ';
		
		// check for an empty string
		if ((fld == null) || (fld.length() == 0))
				return(DT_STRING);
		// see if it qualifies as an int
		// all numbers, only numbers (well, or a leading -)
		numch = fld.charAt(0);
		// 1st char can be -, ., or numeric
		if (!Character.isDigit(numch) && (numch != '-') 
				&& (numch != '.'))
			isNumeric = false;
		else if (numch == '.')
				decimalPtCnt++;
		
		for (i = 1; i < fld.length(); i++) {
			numch = fld.charAt(i);

			if (numch == '.')
				decimalPtCnt++;
			else if (!Character.isDigit(fld.charAt(i)))
				isNumeric = false;
		}

		if (isNumeric) {
			if (decimalPtCnt == 0)
				gTy = DT_INTEGER;
			else if (decimalPtCnt == 1)
				gTy = DT_DOUBLE;
			else 
				isNumeric = false;
		}

		if (!isNumeric)
			gTy = DT_STRING;
		
	return(gTy);
	}
	

}
