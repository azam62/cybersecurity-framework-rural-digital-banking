using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using NAudio.Wave;
namespace Cybersecurity_Framework_for_Rural_Digital_Banking
{
    public class VoiceHelper
    {
        public static double[] ExtractFeatures(string filePath)
        {
            var samples = new System.Collections.Generic.List<float>();

            using (var reader = new MediaFoundationReader(filePath))
            {
                // Resample to mono 16kHz for consistent comparison
                var resampler = new MediaFoundationResampler(reader, new WaveFormat(16000, 1));
                float[] buffer = new float[16000];
                var provider = resampler.ToSampleProvider();
                int read;
                while ((read = provider.Read(buffer, 0, buffer.Length)) > 0)
                {
                    for (int i = 0; i < read; i++)
                        samples.Add(buffer[i]);
                }
            }

            int frameCount = 100;
            double[] features = new double[frameCount];

            if (samples.Count == 0) return features;

            int frameSize = samples.Count / frameCount;
            if (frameSize == 0) return features;

            for (int i = 0; i < frameCount; i++)
            {
                int start = i * frameSize;
                int end = Math.Min(start + frameSize, samples.Count);
                double sumSquares = 0;

                for (int j = start; j < end; j++)
                    sumSquares += samples[j] * samples[j];

                features[i] = Math.Sqrt(sumSquares / (end - start));
            }

            return features;
        }

        public static double CosineSimilarity(double[] v1, double[] v2)
        {
            if (v1.Length != v2.Length) return 0;

            double dot = 0, mag1 = 0, mag2 = 0;

            for (int i = 0; i < v1.Length; i++)
            {
                dot += v1[i] * v2[i];
                mag1 += v1[i] * v1[i];
                mag2 += v2[i] * v2[i];
            }

            if (mag1 == 0 || mag2 == 0) return 0;

            return dot / (Math.Sqrt(mag1) * Math.Sqrt(mag2));
        }

        public static bool CompareVoices(string registeredFilePath, string loginFilePath)
        {
            if (!File.Exists(registeredFilePath) || !File.Exists(loginFilePath))
            {
                string logPath = System.Web.HttpContext.Current.Server.MapPath("~/VoiceScore_Log.txt");
                System.IO.File.AppendAllText(logPath,
                    DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") +
                    " | FILE NOT FOUND | Reg: " + registeredFilePath +
                    " | Login: " + loginFilePath + "\r\n");
                return false;
            }

            try
            {
                double[] features1 = ExtractFeatures(registeredFilePath);
                double[] features2 = ExtractFeatures(loginFilePath);

                double score = CosineSimilarity(features1, features2);

                string logPath = System.Web.HttpContext.Current.Server.MapPath("~/VoiceScore_Log.txt");
                System.IO.File.AppendAllText(logPath,
                    DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") +
                    " | Score: " + score.ToString("F6") +
                    " | Reg: " + registeredFilePath +
                    " | Login: " + loginFilePath + "\r\n");

                return score >= 0.28;
            }
            catch (Exception ex)
            {
                string logPath = System.Web.HttpContext.Current.Server.MapPath("~/VoiceScore_Log.txt");
                System.IO.File.AppendAllText(logPath,
                    DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") +
                    " | ERROR: " + ex.Message + "\r\n");
                return false;
            }
        }

        // Compares login voice against all 3 registered samples
        // Passes if average score is above threshold
        public static bool CompareVoiceWithMultipleSamples(
            string loginFile, string reg1, string reg2, string reg3)
        {
            try
            {
                double[] loginFeatures = ExtractFeatures(loginFile);

                double score1 = File.Exists(reg1) ? CosineSimilarity(loginFeatures, ExtractFeatures(reg1)) : 0;
                double score2 = File.Exists(reg2) ? CosineSimilarity(loginFeatures, ExtractFeatures(reg2)) : 0;
                double score3 = File.Exists(reg3) ? CosineSimilarity(loginFeatures, ExtractFeatures(reg3)) : 0;

                double avgScore = (score1 + score2 + score3) / 3.0;

                // Log for debugging
                string logPath = System.Web.HttpContext.Current.Server.MapPath("~/VoiceScore_Log.txt");
                File.AppendAllText(logPath,
                    DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") +
                    " | S1: " + score1.ToString("F4") +
                    " | S2: " + score2.ToString("F4") +
                    " | S3: " + score3.ToString("F4") +
                    " | AVG: " + avgScore.ToString("F4") + "\r\n");

                return avgScore >= 0.55;
            }
            catch (Exception ex)
            {
                string logPath = System.Web.HttpContext.Current.Server.MapPath("~/VoiceScore_Log.txt");
                File.AppendAllText(logPath, DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") +
                    " | ERROR: " + ex.Message + "\r\n");
                return false;
            }
        }


    }
}

