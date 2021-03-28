<%@ page language="java" contentType="application/json" pageEncoding="UTF-8" %><%@ page import="java.util.*" %>
{
    "resultData": {
        "roomList":[
        	{
            "room_id": 1,
            "createdAt": "2018-02-22T00:00:00.0",
            "use_fg": "Y",
            "doctor_nm": "doctor",
            "room_code": "OS01",
            "room_nm": "진료실1",
            "status": "R",
            "updatedAt": "2018-02-27T12:28:40.0"
        	},
        	{
            "room_id": 2,
            "createdAt": "2018-02-22T00:00:00.0",
            "use_fg": "Y",
            "doctor_nm": "doctor",
            "room_code": "OS02",
            "room_nm": "진료실2",
            "status": "O",
            "updatedAt": "2018-02-27T12:28:40.0"
        	}
        ],
        "acceptList": [
            {
                "noti_fg": "Y",
                "view_id": "OS01",
                "birth": "630102-2******",
                "RANK": 1,
                "createdAt": "20180227",
                "treat_id": 169091,
                "doctor_nm": "박장수",
                "phone": "010-5081-1082",
                "createdTime": "1003",
                "room_no": "OS",
                "patient_nm": "오종숙",
                "room_nm": "정형외과",
                "status": "T"
            },
            {
                "noti_fg": "N",
                "view_id": "OS01",
                "birth": "630102-2******",
                "RANK": 2,
                "createdAt": "20180227",
                "treat_id": 169092,
                "doctor_nm": "박장수",
                "phone": "010-5081-1082",
                "createdTime": "1003",
                "room_no": "OS",
                "patient_nm": "오종숙2",
                "room_nm": "정형외과",
                "status": "C"
            },
            {
                "noti_fg": "N",
                "view_id": "OS01",
                "birth": "630102-2******",
                "RANK": 3,
                "createdAt": "20180227",
                "treat_id": 169093,
                "doctor_nm": "박장수",
                "phone": "010-5081-1082",
                "createdTime": "1003",
                "room_no": "OS",
                "patient_nm": "오종숙3",
                "room_nm": "정형외과",
                "status": "R"
            },
            {
                "noti_fg": "Y",
                "view_id": "OS02",
                "birth": "630102-2******",
                "RANK": 4,
                "createdAt": "20180227",
                "treat_id": 169094,
                "doctor_nm": "박장수2",
                "phone": "010-5081-1082",
                "createdTime": "1003",
                "room_no": "OS",
                "patient_nm": "오종숙4",
                "room_nm": "정형외과",
                "status": "C"
            },
            {
                "noti_fg": "Y",
                "view_id": "OS02",
                "birth": "630102-2******",
                "RANK": 5,
                "createdAt": "20180227",
                "treat_id": 169095,
                "doctor_nm": "박장수2",
                "phone": "010-5081-1082",
                "createdTime": "1003",
                "room_no": "OS",
                "patient_nm": "오종숙5",
                "room_nm": "정형외과",
                "status": "T"
            }
        ]
    }
}