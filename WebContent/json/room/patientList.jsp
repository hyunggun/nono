<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="application/json" pageEncoding="UTF-8" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="startkr.util.RequestUtils"%>
<%@page import="startkr.util.JsonUtils"%>
<%@page import="com.cofac.treat.ora.biz.interlinked.InpatientBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.BedposBiz"%>
<%@page import="com.cofac.treat.ora.biz.non.DocBiz"%>
<%
RequestUtils util = new RequestUtils();
HashMap paramMap = util.makeParamMap(request);
InpatientBiz inpatientBiz = null;
BedposBiz bedposBiz = null;
JSONArray inpatientJAry = new JSONArray();
List inpatientList = null;
List<HashMap<String, String>> inpatientWithColorList = new ArrayList<HashMap<String, String>>(); //화면에 보낼때 쓰일 복제 데이터
try {
	inpatientBiz = new InpatientBiz();
	bedposBiz = new BedposBiz();
	inpatientList = inpatientBiz.selectInpatientList(paramMap);
	HashMap patientMap = new HashMap();
	DocBiz docBiz = new DocBiz();
	
	for(int i = 0 ; i < inpatientList.size(); i++){
		patientMap = (HashMap)inpatientList.get(i);
		
		System.out.println(patientMap);
		// color값 가져오는 작업
		HashMap paramForDocMap = new HashMap();

		String emr_doctor_key = (String)patientMap.get("emr_doctor_key");
		paramForDocMap.put("emr_doctor_key", emr_doctor_key);
		String bedpos = (String)patientMap.get("bedpos");
		
		HashMap doctorMap = docBiz.selectDocColor(paramForDocMap);
		
		if( doctorMap != null ){
			String color = (String)doctorMap.get("color");
			patientMap.put("color", color);
			
			String position = (String)doctorMap.get("position");
			patientMap.put("position", position);
			
		}
		// 컬러값 작업 끝
		
		/*
		** local에서 bedpos 설정할 때 사용하는 소스
		*/
		// bedpos 가져오는 작업
		HashMap paramForbedposMap = new HashMap();

		String addt = (String)patientMap.get("addt");
		paramForbedposMap.put("addt", addt);
		String patient_no = (String)patientMap.get("patient_no");
		paramForbedposMap.put("patient_no", patient_no);
		String room_no = (String)patientMap.get("room_no");
		paramForbedposMap.put("room_no", room_no);
		
		HashMap bedposMap = bedposBiz.selectMaxCnt(paramForbedposMap);
		/* LOCAL bedpos viersion
		HashMap bedposMap = bedposBiz.selectBedpos(paramForbedposMap);
		*/
		if( bedposMap != null ){
			//int bedpos = (int)bedposMap.get("bedpos");
			int maxCnt = (int)bedposMap.get("max_cnt");
			
			if( maxCnt == 6 ){
				if( bedpos.equals("01") ){
					patientMap.put("prioirty", 5);
				}else if( bedpos.equals("02") ){
					patientMap.put("prioirty", 3);
					
				}else if( bedpos.equals("03") ){
					patientMap.put("prioirty", 1);
					
				}else if( bedpos.equals("04") ){
					patientMap.put("prioirty", 2);
					
				}else if( bedpos.equals("05") ){
					patientMap.put("prioirty", 4);
					
				}else if( bedpos.equals("06") ){
					patientMap.put("prioirty", 6);
				}
			}else if( maxCnt == 4 ){
				if( bedpos.equals("01") ){
					patientMap.put("prioirty", 3);
				}else if( bedpos.equals("02") ){
					patientMap.put("prioirty", 1);
					
				}else if( bedpos.equals("03") ){
					patientMap.put("prioirty", 2);
					
				}else if( bedpos.equals("04") ){
					patientMap.put("prioirty", 4);
				}
			}else if( maxCnt == 2 ){
				if( bedpos.equals("01") ){
					patientMap.put("prioirty", 2);
				}else if( bedpos.equals("02") ){
					patientMap.put("prioirty", 1);
				}
			}
		}
		/*
		** local에서 bedpos 설정할 때 사용하는 소스 끝
		*/
		
		
		inpatientWithColorList.add(patientMap);
	}
	inpatientJAry = JsonUtils.getJsonArrayFromList(inpatientWithColorList);
} catch (Exception ex) {
	ex.printStackTrace();
}
%>
{
  "resultData":{
    "inpatientList":<%=(inpatientJAry.toString())%>
  }
}