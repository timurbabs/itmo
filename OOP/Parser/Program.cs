using System;
using System.IO;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace Parser
{
    public class IniParser
    {
        private Dictionary<string, Dictionary<string, string>> data;

        public static IniParser ParseIni(string filename)
        {
            var newData = new IniParser {data = new Dictionary<string, Dictionary<string, string>>()};
            var extension = Path.GetExtension(filename);
            var section = "";
            var param = "";
            var value = "";
            StreamReader fstream = null;
            try
            {
                if (extension != ".ini")
                    throw new Exception("Wrong extension");
                using (fstream = new StreamReader(filename))
                {
                    while (!fstream.EndOfStream)
                    {
                        var mainLine = fstream.ReadLine();
                        var positionLine = mainLine.IndexOf(';');
                        var correctedLine = mainLine.Substring(0, positionLine < 0 ? mainLine.Length : positionLine);
                        if (correctedLine == "")
                            continue;
                        if (ReadParameters(correctedLine, ref param, ref value))
                        {
                            newData.data.Add(param, new Dictionary<string, string>());
                            section = param;
                        }
                        else
                        {
                            if (section == "")
                            {
                                fstream.Dispose();
                                throw new Exception("Wrong structure of file");
                            }

                            newData.data[section].Add(param, value);
                        }
                    }
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine($"Error: {exc.Message}.");
                fstream?.Dispose();
                Environment.Exit(1);
            }

            return newData;
        }

        private static bool ReadParameters(string line, ref string param, ref string value)
        {
            const string sectionPattern = @"^\[[a-zA-Z0-9_]+\]\s*$";
            const string paramPattern = @"^[a-zA-Z0-9_]+\s*=\s*[^\s]+\s*$";
            var sectionRegex = Regex.Match(line, sectionPattern, RegexOptions.IgnoreCase);
            var parameterRegex = Regex.Match(line, paramPattern, RegexOptions.IgnoreCase);

            if (sectionRegex.Success)
            {
                const string bracketsPattern = @"(\[)|(\])";
                var secBrackets = Regex.Split(line, bracketsPattern, RegexOptions.IgnoreCase);
                value = "";
                param = secBrackets[2];

                return true;
            }
            else if (parameterRegex.Success)
            {
                const string valuePattern = @"\s*=\s*";
                var parValue = Regex.Split(line, valuePattern, RegexOptions.IgnoreCase);
                param = parValue[0];
                value = parValue[1];

                return false;
            }
            else
                throw new Exception("Wrong structure of file");
        }

        public void Get<T>(string section, string param)
        {
            try
            {
                if (!data.ContainsKey(section))
                {
                    throw new Exception("Non-existent section");
                }

                if (!data[section].ContainsKey(param))
                {
                    throw new Exception("Non-existent section parameter");
                }

                var tmp = (T) Convert.ChangeType(data[section][param], typeof(T));
                Console.WriteLine(tmp);
            }
            catch (Exception exc)
            {
                Console.WriteLine($"Error: {exc.Message}.");
                Environment.Exit(1);
            }
        }
    }
}