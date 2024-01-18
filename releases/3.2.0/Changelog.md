# CPSV-AP Changelog

## Introduction

This document describes the changes to [the current version 3.1.1](https://semiceu.github.io/CPSV-AP/releases/3.1.1/) of the Core Business Vocabulary for which a new version is being proposed ([version 3.2.0](https://semiceu.github.io/CPSV-AP/releases/3.2.0/)). The list of changes results in the new version to be considered as a minor release.

All of the changes were discussed and approved during the [webinar](https://joinup.ec.europa.eu/collection/semic-support-centre/event/webinar-review-core-vocabularies) of 27/10/2023.

## Changes from v3.1.1 to v3.2.0 
The table below gives an overview of the classes (and their definitions) within both data models. Classes that are related are juxta-positioned.

**C** stands for changes in classes

**R** stands for changes in relationships

**P** stands for changes in properties

**D** stands for changes in data types

### Terms
| Nr | CPSCV-AP v3.1.1 | CPAV-AP v3.2.0 | Rationale                                | GitHub/Change                                                                                                                              |
| -- | ------------------------------- | ------------------------------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| - | - | ReSpec Styling has been applied to the specification.| - | - |
| C1 | DCAT:Dataset                              | DCAT:Dataset                   | The defenition was changed to comply with the autoritativ source. | [#103](https://github.com/SEMICeu/CPSV-AP/issues/103) |
| R1 | CPSV:PublicService.isDescribedAt                              | CPSV:PublicService.isPartOf                   | dct:isPartOf is the inverse relation of dct:hasPart | [#76](https://github.com/SEMICeu/CPSV-AP/issues/76) |
| R2 | CV:ContactPoint.availabilityRestriction         | CV:ContactPoint.availabilityRestriction                   | Additional clarification was provided in the usage note | [#115](https://github.com/SEMICeu/CPSV-AP/issues/115) |
| P1 | CV:Event.type         | CV:BusinessEvent.type                  | The property has been moved to BusinessEvent allowing for the recommendation for the usage of the [Business Event codelist](https://op.europa.eu/en/web/eu-vocabularies/dataset/-/resource?uri=http://publications.europa.eu/resource/dataset/business-event). | [#120](https://github.com/SEMICeu/CPSV-AP/issues/120) |
| P1 | CV:Event.type         | CV:LifesEvent.type                  | The property has been moved to LifeEvent allowing for the recommendation for the usage of the [Life Events codelist](https://op.europa.eu/en/web/eu-vocabularies/dataset/-/resource?uri=http://publications.europa.eu/resource/dataset/life-event). | [#120](https://github.com/SEMICeu/CPSV-AP/issues/120) |




