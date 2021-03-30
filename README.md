# stitching
Batch stitching of images using [wholebrainsoftware](https://github.com/tractatus/wholebrain)  
Additional utilities from wholebrainsoftware are also present [here](https://github.com/tractatus/wholebrain-examples) 

## installing wholebrain software


- For stable instruction with R 3.6.3 [link](ttps://github.com/wAOndering/stitching/blob/master/docs/installInstruction.r)
- Windows [updated instructions](https://github.com/wAOndering/stitching/blob/master/docs/WholeBrainWindowsInstallNov2018.pdf)
- For Linux and MacOS see:
	- [gitter channel](https://gitter.im/tractatus/Lobby)
	- [wholebrainsoftware website](http://www.wholebrainsoftware.org/cms/install/)

## using the stitching batch program

- Open command line (cmd) or terminal and follow those steps:

```R
# navigate to the stitching repository
> cd C:\git\stitching # for example (tips: after tiping cd drag the folder)
> R
> source('stitchMain.r')
```
## stitching option

<img src="docs/stitching_type1-1.png">

_**eg. 1** Output from `option1` in this output the black areas are self generated to complete the specific pattern (other pattern have not been implemented)._

<img src="docs/stitching_type2-1.png">

_**eg. 2** Output from `option2` in this output the black areas have been acquired during imaging._
