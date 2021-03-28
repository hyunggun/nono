package startkr.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {

	// YYYYMMDDhhmmss
	public static String getCurrentDatetime() {
		Calendar cal = Calendar.getInstance();
		String str = String.format("%04d%02d%02d%02d%02d%02d",
				cal.get(Calendar.YEAR), (cal.get(Calendar.MONTH) + 1), cal.get(Calendar.DAY_OF_MONTH),
				cal.get(Calendar.HOUR_OF_DAY), cal.get(Calendar.MINUTE), cal.get(Calendar.SECOND));
		return str;
	}

	// YYYYMMDD
	public static String getCurrentDate() {
		Calendar cal = Calendar.getInstance();
		String str = String.format("%04d%02d%02d", cal.get(Calendar.YEAR), (cal.get(Calendar.MONTH) + 1), cal.get(Calendar.DAY_OF_MONTH));
		return str;
	}

	// Format
	public static String getCurrentDate( String fmt ) {
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat( fmt );
		return format.format(now);
	}

	// Hour
	public static String getCurrentHour() {
		Calendar cal = Calendar.getInstance();
		String str = String.format("%02d", cal.get(Calendar.HOUR_OF_DAY));
		return str;
	}

	public static String checkLateDate( String date1, String date2) {
		// date2
		if( date2 == null || date2.length() != 8 ) {
			if( date1 == null || date1.length() != 8 ) {
				return null;
			} else {
				return date1;
			}
		}
		// date1
		if( date1 == null || date1.length() != 8 ) {
			return date2;
		}

		String lateDate = date2;
		int dtno1 = Integer.parseInt(date1);
		int dtno2 = Integer.parseInt(date2);

		// date1
		if( dtno1 > dtno2 ) lateDate = date1;

		return lateDate;
	}

	public static String checkEarlyDate( String date1, String date2) {
		if( date1 == null || date1.length() != 8 ) {
			if( date2 == null || date2.length() != 8 ) {
				return null;
			} else {
				return date2;
			}
		}

		if( date2 == null || date2.length() != 8 ) {
			return date1;
		}

		String earlyDate = date1;
		int dtno1 = Integer.parseInt(date1);
		int dtno2 = Integer.parseInt(date2);

		if( dtno1 > dtno2 ) earlyDate = date2;

		return earlyDate;
	}


	public static String getCalcDate( int days ) {
		Calendar cal = Calendar.getInstance();
		cal.add( Calendar.DATE , days );
		return String.format("%04d%02d%02d", cal.get(Calendar.YEAR), (cal.get(Calendar.MONTH) + 1), (cal.get(Calendar.DAY_OF_MONTH) ));
	}

	public static String getJSONDateArray( int days ) {
		String aryDates = "'Today'";
		if( days > 1 ) {
			String dateStr = "";
			Calendar cal = Calendar.getInstance();
			for( int i = 1 ; i < days ; i++ ) {
				cal.add( Calendar.DATE , -1 );
				dateStr = String.format("'%04d-%02d-%02d'", cal.get(Calendar.YEAR), (cal.get(Calendar.MONTH) + 1), (cal.get(Calendar.DAY_OF_MONTH) ));
				aryDates = dateStr + "," + aryDates;
			}
		}
		return "[" + aryDates + "]";
	}

}