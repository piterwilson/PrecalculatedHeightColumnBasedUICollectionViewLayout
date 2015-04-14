#PrecalculatedHeightColumnBasedUICollectionViewLayout

![PrecalculatedHeightColumnBasedUICollectionViewLayout](https://cloud.githubusercontent.com/assets/1923693/7138205/077ed81e-e2bf-11e4-8b72-c18a55a6ef05.png)

`PrecalculatedHeightColumnBasedUICollectionViewLayout` is a `UICollectionViewLayout` subclass where the items are placed in vertical columns that are layed out side by side. Each column has items of arbitrary heights.
 
 The height of the items is provided by the items themselves (implementing the `PrecalculatedHeightObject` protocol). The protocol contains a sinle property that must be implemented:
 
 ```
 -(float)precalculatedHeight;
 ```
 
 The width of the columns is specified by the layout. (`columnWidth` property) as is the internal spacing between columns (`columSpacing`, `rowSpacing` properties)
 
 Example :
 
 The pseudo data structure
 
  ```
 [
    [
        {precalculatedHeght : 1}
    ],
    [
        {precalculatedHeght : 1},
        {precalculatedHeght : 2},
        {precalculatedHeght : 3}
    ],
    [
        {precalculatedHeght : 1},
        {precalculatedHeght : 2},
        {precalculatedHeght : 2}
    ]
 ]

 ```
 Results in:
 
  ```
 ┌─────┬─────┬─────┐
 |  1  |  1  |  1  |
 └─────┼─────┼─────┤
       |  2  |  2  |
       |     |     |
       ├─────┼─────┤
       |  3  |  2  |
       |     |     |
       |     ├─────┘
       └─────┘
 ```
 
 #Installation
 
Download the sample project and copy the files under the `PrecalculatedHeightColumnBasedUICollectionViewLayout` folder

#Usage

##PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource

`PrecalculatedHeightColumnBasedUICollectionViewLayout` needs an object to act as its `dataSource`. The class may be of any type as long as it implements the `PrecalculatedHeightColumnBasedUICollectionViewLayoutDataSource` protocol. 

```
-(id <PrecalculatedHeightObject>)objectForColumn:(int)column position:(int)position;
```
This call should return the Object that is positioned at the specified column and position (row) inside that column. The Object should implement the `PrecalculatedHeightObject` protocol. 

```
-(int)numberObjectsInColumn:(int)column;
```
This call should return the number of Objects in the given column index.

```
-(int)numberColumns;
```
This call should return the number of columns to use on the layout.

##PrecalculatedHeightObject

A simple protocol with a single property to override

```
-(float)precalculatedHeight;
```
The property should return the height in pixels for this object in the layout.

Usage
----
See attached Xcode project (Sample was made with XCode 6.2)

License
----

MIT