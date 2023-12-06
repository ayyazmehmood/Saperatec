
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using System.Configuration;
using VerumBusinessObjects;
using VerumBusinessObjects.Framework;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Build configuration
IConfiguration obj = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
    .Build();

LibrarySettings.ClientID = obj.GetValue<string>("AzureConfig:ClientID");
LibrarySettings.Secret = obj.GetValue<string>("AzureConfig:Secret");
LibrarySettings.TenantId = obj.GetValue<string>("AzureConfig:TenantId");
LibrarySettings.MicrosoftLoginUrlToken = obj.GetValue<string>("AzureConfig:MicrosoftLoginUrlToken");
LibrarySettings.ExportFilePath = obj.GetValue<string>("ExportFilePath");

app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "1");
    c.RoutePrefix = "swagger"; // Optional: customize the URL
});

//if (app.Environment.IsDevelopment())
//{
//    app.UseSwagger();
//app.UseSwaggerUI(c =>
//{
//    c.SwaggerEndpoint("/swagger/v1/swagger.json", "1");
//    c.RoutePrefix = "swagger"; // Optional: customize the URL
//});
//}

app.UseCors("AllowAll");

app.MapControllers();

app.MapGet("/", () => "Hello World!");

app.MapPost("/bookplan", (Guid IdPlan, bool force) =>
{
    VerumBusinessObjects.VerumSession session = new VerumBusinessObjects.VerumSession();
    session.Logon("ffriedrich@saperatec.de", "17Draconis$b", "Server=tcp:saperatec01.database.windows.net,1433;Initial Catalog=VerumTest;Persis" +
            "t Security Info=False;User ID=azureadmin;Password=U327Shns\r\n;MultipleActiveResul" +
            "tSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
    VerumBusinessObjects.Plan plan = new VerumBusinessObjects.Plan(IdPlan);
    JobReport report = new JobReport();
    report.StartJob(TypeJobEnum.PlanImplement);
    BOResult result = plan.ImplementPlan(force);
    if (result == BOResult.GeneralError)
    {
        report.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, plan.TitlePlan, "", "Buchen von Plan " + plan.TitlePlan + "mit Id " + plan.IdString + " fehlgeschlagen");
        report.EndJob();
        return Results.Problem();
    }
    else
    {
        report.Report(TypeJobSuccessEnum.Success, BOResult.Success, plan.TitlePlan, "", "Plan " + plan.TitlePlan + " mit Id " + plan.IdString + " erfolgreich gebucht");
        report.EndJob();
        return Results.Ok();
    }
});

app.Run();