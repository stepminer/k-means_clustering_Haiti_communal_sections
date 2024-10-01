# k-means_clustering_Haiti_communal_sections
Shiny app tool for visualizing and exploring socio-economic and geographical clusters of communal sections in Haiti.

**K-Means Clustering of Haiti's Communal Sections Shiny App**

**Overview**
This Shiny app provides a visualization of k-means clustering for Haiti’s communal sections, highlighting different socio-economic and geographical characteristics. The app allows users to explore the clusters of these sections using an interactive map and data table, offering insights into population, poverty rate, proximity to health centers and schools, and other key metrics. The data has been spatially joined with geo-referenced information to allow for comprehensive analysis and visualization.

**Features**
Interactive Map: Explore Haiti's communal sections with dynamic filtering by department and commune.
Cluster Visualization: View the clusters of sections categorized by socio-economic potential, adjacency to urban centers, challenges, and other characteristics.
Data Table: Examine detailed data on each communal section, including population, poverty rates, and proximity to essential services.
Reset Functionality: Easily reset filters to explore different sections without restarting the app.
Data Sources
The app uses the following data:

Cluster Data: Socio-economic and geographical data on Haiti's communal sections, including population and poverty rates.
GeoJSON File: Spatial data for Haiti’s communal sections to enable geographic mapping.
**How to Use**
Department Selection:

Use the sidebar dropdown to select a department. The map and data table will update based on the selected department.
Selecting "All" will display data for all departments.
Commune Selection:

After selecting a department, you can further filter by commune. The communes dropdown will populate based on the selected department.
Selecting "All" will display data for all communes within the chosen department.
Interactive Map:

The map displays communal sections colored by their assigned cluster.
Hover over or click on a section to see detailed information including the section name, cluster, population, and other socio-economic data.
Data Table:

The data table provides a tabular view of the same information displayed on the map.
You can sort and filter columns to focus on specific sections or clusters.
Reset Filters:

Use the reset button to quickly return to the default view showing all departments and communes.
**Installation and Deployment**
**Local Deployment**
To run the app locally:

Clone this repository.
Install necessary R packages using the following command in your R environment:
R
Copy code
install.packages(c("shiny", "leaflet", "DT", "dplyr", "sf", "readr", "readxl"))
Run the Shiny app:
R
Copy code
shiny::runApp("path_to_your_app_directory")
Online Deployment
The app has been deployed online and can be accessed through the following link:

Access the Shiny App

Prerequisites
R version 3.5 or higher
R packages: shiny, leaflet, DT, dplyr, sf, readr, readxl
File Structure
app.R: Main R script containing the UI and server logic.
00_data/full_geosections_clusters_new.csv: Data on Haiti’s communal sections.
00_data/Seksyon_Kominal_simplified.geojson: GeoJSON file containing the spatial data for Haiti's communal sections.
POLLNEX_logo.png: Logo used in the app’s UI.
Known Issues
Loading Time: The map and data table may take a few moments to load due to the size of the dataset.
Deployment Bugs: Some users may experience issues with the app on deployment platforms like Heroku. Ensure all dependencies are properly installed if running into package-related issues.
Contributing
We welcome contributions to this project! If you find a bug or have a feature request, please open an issue or submit a pull request.

Steps to Contribute:
Fork the repository.
Make your changes in a separate branch.
Submit a pull request with a detailed description of your changes.
License
This project is licensed under the MIT License. See the LICENSE file for details.

**Contact**
For questions or feedback, please contact:

Developer: Patrick Stephenson
Email: stepminer@gmail.com









