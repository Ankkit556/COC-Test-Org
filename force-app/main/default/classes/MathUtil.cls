public class MathUtil {
	@Invocablemethod(Label ='Add 2 numbers')
    public static List<Integer> add(List<FlowInput> lstFI){
         
     List<Integer>   results = new List<Integer>();
        for(FlowInput FI : lstFI){
            Integer myint = fi.int1 + FI.int2;
            results.add(myint);
            
        }
        return results;
    }
    public class FlowInput{
        @InvocableVariable(Label = 'Int 1' Required =True)
        public Integer int1;
        @InvocableVariable(Label = 'Int 2' Required =True)
        public Integer int2;
        
    }
}