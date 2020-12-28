# A Toy GIS

Simple implementations of vector/raster GIS tools and mini projects that used them.

## Things We Need

- Point, Line, Polygon feature classes
- Datasets containing records with instances of these
- Views representing a query on physical datasets
- Basic analytical package for creating views
- Visualization of these datasets

## Vector Feature Classes Spec

Point has two coordinates X and Y.

Line is composed of two Points. Has length. Optional order for direction

Polygon is composed of sequence of Points (at least 3) . Init has simple vaidator that checks if first point = last point Assumes clockwise order.

## Datasets and Views as In-Memory Database

In spirit of not using existing postgres spatial DB/etc, Datasets will simply store instances of vector features, and Views as subsets of those.

## Spatial Analytical Package

- Distance between Points --> shortest distance bw Lines.
- Distance between Polygons and between Lines and Points (must consider interior points along Line).
- Area of Polygon
- Contained inside Polygon
- Clip Polygon A with Polygon B (creates new data)
- Erase Polygon A with Polygon B (creates new data)

## Visualization

Use matplotlib

