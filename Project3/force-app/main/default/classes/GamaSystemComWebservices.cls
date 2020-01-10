public class GamaSystemComWebservices {
    public class CurrentConvertToForeign_element {
        public Decimal dcmEUR;
        public String strBank;
        public String strCurrency;
        public Integer intRank;
        private String[] dcmEUR_type_info = new String[]{'dcmEUR','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strCurrency_type_info = new String[]{'strCurrency','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] intRank_type_info = new String[]{'intRank','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'dcmEUR','strBank','strCurrency','intRank'};
    }
    public class GetCurrentExchangeRate_element {
        public String strBank;
        public String strCurrency;
        public Integer intRank;
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strCurrency_type_info = new String[]{'strCurrency','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] intRank_type_info = new String[]{'intRank','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'strBank','strCurrency','intRank'};
    }
    public class GetCurrentExchangeRatesXML_element {
        public String strBank;
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'strBank'};
    }
    public class GetExchangeRateResponse_element {
        public Decimal GetExchangeRateResult;
        private String[] GetExchangeRateResult_type_info = new String[]{'GetExchangeRateResult','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'GetExchangeRateResult'};
    }
    public class GetExchangeRatesXMLSchemaResponse_element {
        public String GetExchangeRatesXMLSchemaResult;
        private String[] GetExchangeRatesXMLSchemaResult_type_info = new String[]{'GetExchangeRatesXMLSchemaResult','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'GetExchangeRatesXMLSchemaResult'};
    }
    public class GetExchangeRatesXMLResponse_element {
        public String GetExchangeRatesXMLResult;
        private String[] GetExchangeRatesXMLResult_type_info = new String[]{'GetExchangeRatesXMLResult','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'GetExchangeRatesXMLResult'};
    }
    public class GetExchangeRate_element {
        public String strBank;
        public String strCurrency;
        public String strDate;
        public Integer intRank;
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strCurrency_type_info = new String[]{'strCurrency','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strDate_type_info = new String[]{'strDate','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] intRank_type_info = new String[]{'intRank','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'strBank','strCurrency','strDate','intRank'};
    }
    public class GetExchangeRatesByValueXML_element {
        public String strBank;
        public String strCurrency;
        public Decimal dcmLow;
        public Decimal dcmHigh;
        public Integer intRank;
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strCurrency_type_info = new String[]{'strCurrency','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] dcmLow_type_info = new String[]{'dcmLow','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] dcmHigh_type_info = new String[]{'dcmHigh','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] intRank_type_info = new String[]{'intRank','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'strBank','strCurrency','dcmLow','dcmHigh','intRank'};
    }
    public class GetExchangeRatesXML_element {
        public String strBank;
        public String strDate;
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strDate_type_info = new String[]{'strDate','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'strBank','strDate'};
    }
    public class ConvertToForeignResponse_element {
        public Decimal ConvertToForeignResult;
        private String[] ConvertToForeignResult_type_info = new String[]{'ConvertToForeignResult','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'ConvertToForeignResult'};
    }
    public class ConvertToEUR_element {
        public Decimal dcmValue;
        public String strBank;
        public String strCurrency;
        public String strDate;
        public Integer intRank;
        private String[] dcmValue_type_info = new String[]{'dcmValue','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strCurrency_type_info = new String[]{'strCurrency','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strDate_type_info = new String[]{'strDate','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] intRank_type_info = new String[]{'intRank','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'dcmValue','strBank','strCurrency','strDate','intRank'};
    }
    public class GetExchangeRatesXMLSchema_element {
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class GetExchangeRatesByDateXML_element {
        public String strBank;
        public String strCurrency;
        public String strDateLow;
        public String strDateHigh;
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strCurrency_type_info = new String[]{'strCurrency','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strDateLow_type_info = new String[]{'strDateLow','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strDateHigh_type_info = new String[]{'strDateHigh','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'strBank','strCurrency','strDateLow','strDateHigh'};
    }
    public class GetCurrentExchangeRateResponse_element {
        public Decimal GetCurrentExchangeRateResult;
        private String[] GetCurrentExchangeRateResult_type_info = new String[]{'GetCurrentExchangeRateResult','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'GetCurrentExchangeRateResult'};
    }
    public class CurrentConvertToForeignResponse_element {
        public Decimal CurrentConvertToForeignResult;
        private String[] CurrentConvertToForeignResult_type_info = new String[]{'CurrentConvertToForeignResult','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'CurrentConvertToForeignResult'};
    }
    public class GetCurrentExchangeRatesXMLResponse_element {
        public String GetCurrentExchangeRatesXMLResult;
        private String[] GetCurrentExchangeRatesXMLResult_type_info = new String[]{'GetCurrentExchangeRatesXMLResult','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'GetCurrentExchangeRatesXMLResult'};
    }
    public class CurrentConvertToEURResponse_element {
        public Decimal CurrentConvertToEURResult;
        private String[] CurrentConvertToEURResult_type_info = new String[]{'CurrentConvertToEURResult','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'CurrentConvertToEURResult'};
    }
    public class ConvertToEURResponse_element {
        public Decimal ConvertToEURResult;
        private String[] ConvertToEURResult_type_info = new String[]{'ConvertToEURResult','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'ConvertToEURResult'};
    }
    public class GetExchangeRatesByDateXMLResponse_element {
        public String GetExchangeRatesByDateXMLResult;
        private String[] GetExchangeRatesByDateXMLResult_type_info = new String[]{'GetExchangeRatesByDateXMLResult','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'GetExchangeRatesByDateXMLResult'};
    }
    public class GetExchangeRatesByValueXMLResponse_element {
        public String GetExchangeRatesByValueXMLResult;
        private String[] GetExchangeRatesByValueXMLResult_type_info = new String[]{'GetExchangeRatesByValueXMLResult','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'GetExchangeRatesByValueXMLResult'};
    }
    public class CurrentConvertToEUR_element {
        public Decimal dcmValue;
        public String strBank;
        public String strCurrency;
        public Integer intRank;
        private String[] dcmValue_type_info = new String[]{'dcmValue','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strCurrency_type_info = new String[]{'strCurrency','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] intRank_type_info = new String[]{'intRank','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'dcmValue','strBank','strCurrency','intRank'};
    }
    public class ConvertToForeign_element {
        public Decimal dcmEUR;
        public String strBank;
        public String strCurrency;
        public String strDate;
        public Integer intRank;
        private String[] dcmEUR_type_info = new String[]{'dcmEUR','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] strBank_type_info = new String[]{'strBank','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strCurrency_type_info = new String[]{'strCurrency','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] strDate_type_info = new String[]{'strDate','http://www.gama-system.com/webservices',null,'0','1','false'};
        private String[] intRank_type_info = new String[]{'intRank','http://www.gama-system.com/webservices',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.gama-system.com/webservices','true','false'};
        private String[] field_order_type_info = new String[]{'dcmEUR','strBank','strCurrency','strDate','intRank'};
    }
    public class ExchangeRatesSoap {
        public String endpoint_x = 'http://webservices.gama-system.com/exchangerates.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://www.gama-system.com/webservices', 'GamaSystemComWebservices'};
        public String GetExchangeRatesByValueXML(String strBank,String strCurrency,Decimal dcmLow,Decimal dcmHigh,Integer intRank) {
            GamaSystemComWebservices.GetExchangeRatesByValueXML_element request_x = new GamaSystemComWebservices.GetExchangeRatesByValueXML_element();
            request_x.strBank = strBank;
            request_x.strCurrency = strCurrency;
            request_x.dcmLow = dcmLow;
            request_x.dcmHigh = dcmHigh;
            request_x.intRank = intRank;
            GamaSystemComWebservices.GetExchangeRatesByValueXMLResponse_element response_x;
            Map<String, GamaSystemComWebservices.GetExchangeRatesByValueXMLResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.GetExchangeRatesByValueXMLResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/GetExchangeRatesByValueXML',
              'http://www.gama-system.com/webservices',
              'GetExchangeRatesByValueXML',
              'http://www.gama-system.com/webservices',
              'GetExchangeRatesByValueXMLResponse',
              'GamaSystemComWebservices.GetExchangeRatesByValueXMLResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetExchangeRatesByValueXMLResult;
        }
        public Decimal ConvertToEUR(Decimal dcmValue,String strBank,String strCurrency,String strDate,Integer intRank) {
            GamaSystemComWebservices.ConvertToEUR_element request_x = new GamaSystemComWebservices.ConvertToEUR_element();
            request_x.dcmValue = dcmValue;
            request_x.strBank = strBank;
            request_x.strCurrency = strCurrency;
            request_x.strDate = strDate;
            request_x.intRank = intRank;
            GamaSystemComWebservices.ConvertToEURResponse_element response_x;
            Map<String, GamaSystemComWebservices.ConvertToEURResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.ConvertToEURResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/ConvertToEUR',
              'http://www.gama-system.com/webservices',
              'ConvertToEUR',
              'http://www.gama-system.com/webservices',
              'ConvertToEURResponse',
              'GamaSystemComWebservices.ConvertToEURResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.ConvertToEURResult;
        }
        public Decimal CurrentConvertToEUR(Decimal dcmValue,String strBank,String strCurrency,Integer intRank) {
            GamaSystemComWebservices.CurrentConvertToEUR_element request_x = new GamaSystemComWebservices.CurrentConvertToEUR_element();
            request_x.dcmValue = dcmValue;
            request_x.strBank = strBank;
            request_x.strCurrency = strCurrency;
            request_x.intRank = intRank;
            GamaSystemComWebservices.CurrentConvertToEURResponse_element response_x;
            Map<String, GamaSystemComWebservices.CurrentConvertToEURResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.CurrentConvertToEURResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/CurrentConvertToEUR',
              'http://www.gama-system.com/webservices',
              'CurrentConvertToEUR',
              'http://www.gama-system.com/webservices',
              'CurrentConvertToEURResponse',
              'GamaSystemComWebservices.CurrentConvertToEURResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.CurrentConvertToEURResult;
        }
        public Decimal GetExchangeRate(String strBank,String strCurrency,String strDate,Integer intRank) {
            GamaSystemComWebservices.GetExchangeRate_element request_x = new GamaSystemComWebservices.GetExchangeRate_element();
            request_x.strBank = strBank;
            request_x.strCurrency = strCurrency;
            request_x.strDate = strDate;
            request_x.intRank = intRank;
            GamaSystemComWebservices.GetExchangeRateResponse_element response_x;
            Map<String, GamaSystemComWebservices.GetExchangeRateResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.GetExchangeRateResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/GetExchangeRate',
              'http://www.gama-system.com/webservices',
              'GetExchangeRate',
              'http://www.gama-system.com/webservices',
              'GetExchangeRateResponse',
              'GamaSystemComWebservices.GetExchangeRateResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetExchangeRateResult;
        }
        public Decimal CurrentConvertToForeign(Decimal dcmEUR,String strBank,String strCurrency,Integer intRank) {
            GamaSystemComWebservices.CurrentConvertToForeign_element request_x = new GamaSystemComWebservices.CurrentConvertToForeign_element();
            request_x.dcmEUR = dcmEUR;
            request_x.strBank = strBank;
            request_x.strCurrency = strCurrency;
            request_x.intRank = intRank;
            GamaSystemComWebservices.CurrentConvertToForeignResponse_element response_x;
            Map<String, GamaSystemComWebservices.CurrentConvertToForeignResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.CurrentConvertToForeignResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/CurrentConvertToForeign',
              'http://www.gama-system.com/webservices',
              'CurrentConvertToForeign',
              'http://www.gama-system.com/webservices',
              'CurrentConvertToForeignResponse',
              'GamaSystemComWebservices.CurrentConvertToForeignResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.CurrentConvertToForeignResult;
        }
        public Decimal ConvertToForeign(Decimal dcmEUR,String strBank,String strCurrency,String strDate,Integer intRank) {
            GamaSystemComWebservices.ConvertToForeign_element request_x = new GamaSystemComWebservices.ConvertToForeign_element();
            request_x.dcmEUR = dcmEUR;
            request_x.strBank = strBank;
            request_x.strCurrency = strCurrency;
            request_x.strDate = strDate;
            request_x.intRank = intRank;
            GamaSystemComWebservices.ConvertToForeignResponse_element response_x;
            Map<String, GamaSystemComWebservices.ConvertToForeignResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.ConvertToForeignResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/ConvertToForeign',
              'http://www.gama-system.com/webservices',
              'ConvertToForeign',
              'http://www.gama-system.com/webservices',
              'ConvertToForeignResponse',
              'GamaSystemComWebservices.ConvertToForeignResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.ConvertToForeignResult;
        }
        public Decimal GetCurrentExchangeRate(String strBank,String strCurrency,Integer intRank) {
            GamaSystemComWebservices.GetCurrentExchangeRate_element request_x = new GamaSystemComWebservices.GetCurrentExchangeRate_element();
            request_x.strBank = strBank;
            request_x.strCurrency = strCurrency;
            request_x.intRank = intRank;
            GamaSystemComWebservices.GetCurrentExchangeRateResponse_element response_x;
            Map<String, GamaSystemComWebservices.GetCurrentExchangeRateResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.GetCurrentExchangeRateResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/GetCurrentExchangeRate',
              'http://www.gama-system.com/webservices',
              'GetCurrentExchangeRate',
              'http://www.gama-system.com/webservices',
              'GetCurrentExchangeRateResponse',
              'GamaSystemComWebservices.GetCurrentExchangeRateResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetCurrentExchangeRateResult;
        }
        public String GetExchangeRatesXML(String strBank,String strDate) {
            GamaSystemComWebservices.GetExchangeRatesXML_element request_x = new GamaSystemComWebservices.GetExchangeRatesXML_element();
            request_x.strBank = strBank;
            request_x.strDate = strDate;
            GamaSystemComWebservices.GetExchangeRatesXMLResponse_element response_x;
            Map<String, GamaSystemComWebservices.GetExchangeRatesXMLResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.GetExchangeRatesXMLResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/GetExchangeRatesXML',
              'http://www.gama-system.com/webservices',
              'GetExchangeRatesXML',
              'http://www.gama-system.com/webservices',
              'GetExchangeRatesXMLResponse',
              'GamaSystemComWebservices.GetExchangeRatesXMLResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetExchangeRatesXMLResult;
        }
        public String GetExchangeRatesXMLSchema() {
            GamaSystemComWebservices.GetExchangeRatesXMLSchema_element request_x = new GamaSystemComWebservices.GetExchangeRatesXMLSchema_element();
            GamaSystemComWebservices.GetExchangeRatesXMLSchemaResponse_element response_x;
            Map<String, GamaSystemComWebservices.GetExchangeRatesXMLSchemaResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.GetExchangeRatesXMLSchemaResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/GetExchangeRatesXMLSchema',
              'http://www.gama-system.com/webservices',
              'GetExchangeRatesXMLSchema',
              'http://www.gama-system.com/webservices',
              'GetExchangeRatesXMLSchemaResponse',
              'GamaSystemComWebservices.GetExchangeRatesXMLSchemaResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetExchangeRatesXMLSchemaResult;
        }
        public String GetCurrentExchangeRatesXML(String strBank) {
            GamaSystemComWebservices.GetCurrentExchangeRatesXML_element request_x = new GamaSystemComWebservices.GetCurrentExchangeRatesXML_element();
            request_x.strBank = strBank;
            GamaSystemComWebservices.GetCurrentExchangeRatesXMLResponse_element response_x;
            Map<String, GamaSystemComWebservices.GetCurrentExchangeRatesXMLResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.GetCurrentExchangeRatesXMLResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/GetCurrentExchangeRatesXML',
              'http://www.gama-system.com/webservices',
              'GetCurrentExchangeRatesXML',
              'http://www.gama-system.com/webservices',
              'GetCurrentExchangeRatesXMLResponse',
              'GamaSystemComWebservices.GetCurrentExchangeRatesXMLResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetCurrentExchangeRatesXMLResult;
        }
        public String GetExchangeRatesByDateXML(String strBank,String strCurrency,String strDateLow,String strDateHigh) {
            GamaSystemComWebservices.GetExchangeRatesByDateXML_element request_x = new GamaSystemComWebservices.GetExchangeRatesByDateXML_element();
            request_x.strBank = strBank;
            request_x.strCurrency = strCurrency;
            request_x.strDateLow = strDateLow;
            request_x.strDateHigh = strDateHigh;
            GamaSystemComWebservices.GetExchangeRatesByDateXMLResponse_element response_x;
            Map<String, GamaSystemComWebservices.GetExchangeRatesByDateXMLResponse_element> response_map_x = new Map<String, GamaSystemComWebservices.GetExchangeRatesByDateXMLResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.gama-system.com/webservices/GetExchangeRatesByDateXML',
              'http://www.gama-system.com/webservices',
              'GetExchangeRatesByDateXML',
              'http://www.gama-system.com/webservices',
              'GetExchangeRatesByDateXMLResponse',
              'GamaSystemComWebservices.GetExchangeRatesByDateXMLResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetExchangeRatesByDateXMLResult;
        }
    }
}