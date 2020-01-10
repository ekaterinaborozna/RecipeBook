public class StringArrayTest
        {
            public static List<String> generateStringArray(Integer n)
            {
                System.debug(n);
                List<String> str = new List<String>();
                
                for(Integer i=0;i<n;i++)
                {
                    str.add('Test '+i);
                }
                System.debug(str);
                return str;
            }
        }