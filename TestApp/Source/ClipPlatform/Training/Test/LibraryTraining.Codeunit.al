namespace ClipPlatform.Training.Test;
using ClipPlatform.Training.MasterData;
using ClipPlatform.Training.Setup;
using Microsoft.Projects.Resources.Resource;
codeunit 50153 "Library - Training"
{
    procedure CreateTraining() Training: Record Training
    begin
        CheckTrainingSetup();
        Training.Init();
        Training.Insert(true);
        Training.Price := 450;
        Training.Name := 'Una formación de test ' + Training."No.";
        Training.Modify(true);
    end;

    local procedure CheckTrainingSetup()
    var
        TrainingSetup: Record "Training Setup";
        LibraryUtility: Codeunit "Library - Utility";
        NoSeriesCode: Code[20];
    begin
        if not TrainingSetup.Get() then begin
            TrainingSetup.Init();
            TrainingSetup.Insert(true);
        end;
        NoSeriesCode := LibraryUtility.GetGlobalNoSeriesCode();
        if NoSeriesCode <> TrainingSetup."Training Nos." then begin
            TrainingSetup.Validate("Training Nos.", LibraryUtility.GetGlobalNoSeriesCode());
            TrainingSetup.Modify(true);
        end;
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

    internal procedure CreateTrainingEdition(TrainingNo: Code[20]) TrainingEdition: Record "Training Edition";
    var
        LibraryRandom: Codeunit "Library - Random";
    begin
        LibraryRandom.Init();

        TrainingEdition.Init();
        TrainingEdition.Validate("Training No.", TrainingNo);
        TrainingEdition.Validate(Edition, CopyStr(LibraryRandom.RandText(MaxStrLen(TrainingEdition.Edition)), 1, MaxStrLen(TrainingEdition.Edition)));
        TrainingEdition.Validate("Max. students", 10);
        TrainingEdition.Insert(true);
    end;
}