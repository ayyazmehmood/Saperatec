namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using VerumBusinessObjects.Framework;
    using System.ComponentModel.DataAnnotations;
    using DocumentFormat.OpenXml.Office2010.ExcelAc;
    using System.Collections.Generic;
    using DocumentFormat.OpenXml.Office2013.Word;

    /// <summary>
    /// Specifies currencies and enables the conversion of foreign currency into the client base currency
    /// </summary>    
    public partial class Client : BusinessObject<tClient>, IClient
    {
        public bool SelectViaKey(string code)
        {
            var attr = (StringLengthAttribute)typeof(tClient).GetProperty("TitleClient").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tClient.Where(b => b.TitleClient == code);

            if (obj.Count() == 0)
            {
                return false;
            }
            else
            {
                Id = obj.FirstOrDefault().Id;
                return true;
            }
        }

        public static List<RunningClientModel> GetClientIds(Guid clientId, Guid userId)
        {
            try
            {
                if(clientId.Equals(Guid.Empty) || clientId == null)
                {
                    return VerumInstance.Context.tClient.Select(x => new RunningClientModel
                    {
                        GuidId = x.Id,
                        IsRunning = false,
                        Title = x.TitleClient,
                        BCUrl = x.BusinessCenterUrl
                    }).ToList();
                }
                else
                {
                    return VerumInstance.Context.tClient.Where(y=>y.Id== clientId).Select(x => new RunningClientModel
                    {
                        GuidId = x.Id,
                        IsRunning = false,
                        Title = x.TitleClient,
                        BCUrl = x.BusinessCenterUrl,
                        UserId = userId
                    }).ToList();
                }
            }
            catch(Exception ex)
            {
                return new List<RunningClientModel>();
            }
        }

        public static RunningClientModel FindClientIdForRunning(Guid guidId)
        {
            try
            {
                return VerumInstance.Context.tClient.Where(y=>y.Id==guidId).Select(x => new RunningClientModel
                {
                    GuidId = x.Id,
                    IsRunning = false,
                    Title = x.TitleClient
                }).FirstOrDefault();
            }
            catch (Exception ex)
            {
                return new RunningClientModel();
            }
        }

        public static bool UpdateLastCallDateBC(Guid clientId, DateTime dateTime)
        {
            using (var transaction = VerumInstance.Context.Database.BeginTransaction())
            {
                try
                {
                    var updateTime = DateTime.UtcNow;

                    var client = VerumInstance.Context.tClient.Where(x => x.Id == clientId).FirstOrDefault();
                    
                    if (client != null)
                        client.BCLastUpdate = dateTime;

                    VerumInstance.Context.SaveChanges();

                    transaction.Commit();

                    return true;
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    return false;
                }
            }
        }

        public static BOCollection<Client, tClient> GetBOCollectionLastEntryBC()
        {
            var query = VerumInstance.Context.tClient.Where<tClient>(b => b.Id == VerumInstance.IdClient && b.BCLastUpdate > DateTime.MinValue).Take(1);
            
            return new BOCollection<Client, tClient>(query);
        }

        public static BOCollection<Client, tClient> GetBOCollection()
        {
            var query = VerumInstance.Context.tClient.Where<tClient>(b => b.Id == VerumInstance.IdClient);

            return new BOCollection<Client, tClient>(query);
        }

        public static string GetBOCollectionBCUrl()
        {
            var url = VerumInstance.Context.tClient.Where<tClient>(b => b.Id == VerumInstance.IdClient).Select(x=>x.BusinessCenterUrl).FirstOrDefault();

            return url;
        }

        public static bool UpdateBCUrl(string url)
        {
            using (var transaction = VerumInstance.Context.Database.BeginTransaction())
            {
                try
                {
                    var updateTime = DateTime.UtcNow;

                    var client = VerumInstance.Context.tClient.Where(x => x.Id == VerumInstance.IdClient).FirstOrDefault();

                    if (client != null)
                        client.BusinessCenterUrl = url;

                    VerumInstance.Context.SaveChanges();

                    transaction.Commit();

                    return true;
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    return false;
                }
            }
        }
    }
}
