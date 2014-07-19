package airQuality;

import java.io.IOException;

import org.apache.pig.EvalFunc;
import org.apache.pig.PigWarning;
import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;

public class ReplaceCommas extends EvalFunc<String> {

	// should probably make this part of a constructor
	private static char repl = '|';
	
	public static void main(String[] args) {
		Tuple testTuple = TupleFactory.getInstance().newTuple(1);
		try {
			testTuple.set(0, ",Test,\"this quoted (,) string\",stuff,5 commas,");
		} catch (ExecException e) {
			e.printStackTrace();
		}
		
		ReplaceCommas ptst = new ReplaceCommas();
		try {
			String commasReplaced = ptst.exec(testTuple);
			System.out.println(commasReplaced);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public String exec(Tuple arg0) throws IOException {
		Boolean inString = false;
		char c = '_';
		
		String wholeTuple = (String) arg0.get(0);
		StringBuffer sb = new StringBuffer(wholeTuple.length());
		for (int i = 0; i < wholeTuple.length(); i++) {
			c = wholeTuple.charAt(i);
			// On the off chance we encounter the delimiter in the
			// data, warn the caller.
			if (c == repl) {
				warn("Encountered delimiter in data!", PigWarning.UDF_WARNING_1);
				continue;	// better than nothing, I guess  :D
			}
			
			switch(c) {
			case '"':
				// Do not print out double-quotes, but keep track of 
				// whether we're in a quoted string, as they may have
				// embedded commas.
				if (inString)
					inString = false;
				else
					inString = true;
				break;
				
			case ',':
				// If we're not in the middle of a quoted string, 
				// replace commas with their replacement value.
				if (!inString)
					sb.append(repl);
				else
					sb.append(c);
				break;

			default:
				sb.append(c);
				break;
			}
		}
		
		return sb.toString();
	}

}
