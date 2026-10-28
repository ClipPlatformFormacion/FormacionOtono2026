namespace ClipPlatform.DemoApplicationArea;

using System.Environment.Configuration;

tableextension 50101 "Application Area Setup" extends "Application Area Setup"
{
    fields
    {
        field(50100; Training; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}