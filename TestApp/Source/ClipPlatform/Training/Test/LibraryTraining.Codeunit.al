namespace ClipPlatform.Training.Test;
using ClipPlatform.Training.MasterData;
using Microsoft.Projects.Resources.Resource;
codeunit 50153 "Library - Training"
{
    procedure CreateTraining() Training: Record Training
    begin
        Training.Init();
        Training.Insert(true);
        Training.Price := 450;
        Training.Name := 'Una formación de test ' + Training."No.";
        Training.Modify(true);
    end;

    procedure CreateResource() Resource: Record Resource
    begin
        Resource.Init();
        Resource.Insert(true);
    end;

    procedure CreateResource(TrainingNo: Code[20]) Resource: Record Resource
    begin
        Resource := CreateResource();
        Resource.Validate("Training No.", TrainingNo);
        Resource.Modify(true);
    end;
}