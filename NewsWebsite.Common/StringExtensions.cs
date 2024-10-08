﻿using System;
using System.Text.RegularExpressions;

namespace NewsWebsite.Common
{
    public static class StringExtensions
    {
        public static bool HasValue(this string value, bool ignoreWhiteSpace = true)
        {
            return ignoreWhiteSpace ? !string.IsNullOrWhiteSpace(value) : !string.IsNullOrEmpty(value);
        }

        public static bool? ToNullablebool(this string s)
        {
            bool i;
            if (bool.TryParse(s, out i)) return i;
            return null;
        }
        
        public static int? ToNullableInt(this string s)
        {
            int i;
            if (int.TryParse(s, out i)) return i;
            return null;
        }

        public static DateTime? ToNullableDatetime(this string s)
        {
            DateTime i;
            if (DateTime.TryParse(s, out i)) return i;
            return null;
        }
        public static long? ToNullableBigInt(this string s)
        {
            long i;
            if (long.TryParse(s, out i)) return i;
            return null;
        }

        public static float? ToNullablefloat(this string s)
        {
            float i;
            if (float.TryParse(s, out i)) return i;
            return null;
        }

        public static int ToInt(this string value)
        {
            return Convert.ToInt32(value);
        }

        public static decimal ToDecimal(this string value)
        {
            return Convert.ToDecimal(value);
        }

        public static string ToNumeric(this int value)
        {
            return En2Fa(value.ToString("N0")); //"123,456"
        }

        public static string ToNumeric(this decimal value)
        {
            return value.ToString("N0");
        }

        public static string ToCurrency(this int value)
        {
            //fa-IR => current culture currency symbol => ریال
            //123456 => "123,123ریال"
            return value.ToString("C0");
        }

        public static string ToCurrency(this decimal value)
        {
            return value.ToString("C0");
        }

        public static string En2Fa(this string str)
        {
            return str.Replace("0", "۰")
                .Replace("1", "۱")
                .Replace("2", "۲")
                .Replace("3", "۳")
                .Replace("4", "۴")
                .Replace("5", "۵")
                .Replace("6", "۶")
                .Replace("7", "۷")
                .Replace("8", "۸")
                .Replace("9", "۹");
        }

        public static string Fa2En(this string str)
        {
            return str.Replace("۰", "0")
                .Replace("۱", "1")
                .Replace("۲", "2")
                .Replace("۳", "3")
                .Replace("۴", "4")
                .Replace("۵", "5")
                .Replace("۶", "6")
                .Replace("۷", "7")
                .Replace("۸", "8")
                .Replace("۹", "9")
                //iphone numeric
                .Replace("٠", "0")
                .Replace("١", "1")
                .Replace("٢", "2")
                .Replace("٣", "3")
                .Replace("٤", "4")
                .Replace("٥", "5")
                .Replace("٦", "6")
                .Replace("٧", "7")
                .Replace("٨", "8")
                .Replace("٩", "9")
            .Replace(",", "/");
        }

        public static string FixPersianChars(this string str)
        {
            return str.Replace("ﮎ", "ک")
                .Replace("ﮏ", "ک")
                .Replace("ﮐ", "ک")
                .Replace("ﮑ", "ک")
                .Replace("ك", "ک")
                .Replace("ي", "ی")
                .Replace(" ", " ")
                .Replace("‌", " ")
                .Replace("ھ", "ه");//.Replace("ئ", "ی");
        }

        public static string CleanString(this string str)
        {
            return str.Trim().FixPersianChars().Fa2En().NullIfEmpty();
        }

        public static string NullIfEmpty(this string str)
        {
            return str?.Length == 0 ? null : str;
        }

        public static string GenerateId(int numOfCharacter)
        {
            return Guid.NewGuid().ToString("N").Substring(0, numOfCharacter);
        }

        public static string CombineWith(this string[] array, char character)
        {
            string newString = "";
            foreach (var item in array)
            {
                if (newString == "")
                    newString = item;
                else
                    newString = newString + character + item;
            }
            return newString;
        }

        public static int GetNumOfWeek(this string week)
        {
            string[] weekArray = { "شنبه", "یکشنبه", "دوشنبه", "سه شنبه", "چهار شنبه", "پنج شنبه", "جمعه" };
            return Array.IndexOf(weekArray, week);
        }

        public static string[] GetMonth()
        {
            string[] month = { "فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند" };
            return month;
        }
        
        public static int ParseInt(this string? input){
            if (input == null)
                return 0;
        
            string cleanedInput = Regex.Replace(input, "[^0-9]", "");

            if (cleanedInput == "")
                return 0;

            return int.Parse(cleanedInput);
        }
        
    }
}
