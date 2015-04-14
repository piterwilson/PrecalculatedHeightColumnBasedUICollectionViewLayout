
#PrecalculatedHeightColumnBasedUICollectionViewLayout

`PrecalculatedHeightColumnBasedUICollectionViewLayout` is a `UICollectionViewLayout` subclass where the items are placed in vertical columns that are layed out side by side. Each column has items of trivial heights.

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
		{precalculatedHeght : 1},
		{precalculatedHeght : 2},
		{precalculatedHeght : 3}
	],

	[
		{precalculatedHeght : 1},
		{precalculatedHeght : 2},
		{precalculatedHeght : 2}
	],

	[
		{precalculatedHeght : 1}
	]
	
]

```
Results in something like:

```
┌─────┬─────┬─────┐
|  1  |  1  |  1  |
└─────┼─────┼─────┘
|  2  |  2  |
|     |     |
├─────┼─────┤
|  3  |  2  |
|     |     |
|     ├─────┘
└─────┘
```