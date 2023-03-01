# Motivational Overview 

We initially set up hosted feature layers in ArcGIS Online where domains are ESRI-fied.  If you use a web browser or ArcGIS Pro to consume the hosted feature layer views you will see columns with names like "Borough" populated with values like "Brooklyn."  If however you are a normal person who downloads shapefiles or consumes the REST endpoint you will see columns like "Borough" populated with values like "2."

The steps below should be broadly applicable to future schema changes.  We will document them in excruciating detail and without bias of head or heart.

# Excruciating Details

## Stop FME Automations

The automations run chunks of interrelated updates, like buildings and building_historic.  

As the automation owner in FME Server navigate to Automations, manage automation, check the box and Actions-Stop.

## Edit Schema in ArcGIS Online

Log in to ArcGIS Online as the data owner account.

Add New Fields 

1. Navigate to the layer you want to edit, navigate to the XXX Layers folder
2. Click on the layer you want to edit from the list, and navigate to the Data tab
3. Navigate to the Fields view
4. Optional - inspect the Fields that have domains to validate the fields that need to be added
5. Go back to the Fields view
6. Click the Add button
7. Add Field Name with _VALUE
8. Click Add New Field button
9. Validate that Field has been added by going back to Fields view

Deleting the Domains

1. Navigate to the field that has a domain
2. Click Edit List of Values
3. Click Delete List at Bottom Left
4. Click Ok when it says are you sure
5. Click Save at Bottom Right

Editing the Views

1. Navigate to the View by looking at "other views" from the source feature layer or navigate to the Views folder
2. Once you're at view item details, Navigate to Settings and click Update View
3. Click Next
4. Click the layer you want to update
5. Click Fields
6. Click Select Fields and toggle on the fields you want
7. Click Done
8. Click Back
9. Click Update

## Update the Source Authoritative Datasets

1. Add columns named xxx_value. For example add feature_code_value next to feature_code
2. Populate xxx_value with the full text values


## Update FME Workspace

(very high level)

1. Download the workspace from FME Server in production
2. Open in FME Desktop
3. Strip out the python post-processing script.
4. Highlight just the reader and update
5. Some more stuff here
6. Run from FME desktop to success
7. Publish to FME Server in staging and verify
8. Publish to FME Server in production and verify
9. If all workspaces in the automation have been updated re-enable the automation 