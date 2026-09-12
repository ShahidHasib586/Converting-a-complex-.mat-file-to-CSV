# NASA battery impedance data to CSV

A MATLAB script for extracting impedance measurements from a nested NASA battery MAT file. The repository includes `processingData.m` and the `B0005.mat` example.

## Usage

Open the repository folder in MATLAB and run:

```matlab
run('processingData.m')
```

The script reads the `B0005` structure and iterates through its cycles. For impedance cycles, it exports measurement values and separates complex quantities into real and imaginary columns.

## Outputs

| File | Current behaviour |
| --- | --- |
| `B0005.csv` | Impedance cycle measurements, timestamp information, resistance terms, and complex components. |
| `B0005-discharge.csv` | Header only; discharge row export is not implemented in the current script. |

The implementation is specific to the structure of `B0005.mat`. For another battery file, update both the filename and structure field references. It is not a general converter for arbitrary MAT files. Existing output files with these names are overwritten.

## Data attribution

The example is identified in the original project as NASA battery data. Preserve the dataset's source attribution and usage terms when redistributing data or derived results.

Related work: [Electric vehicle range prediction](https://github.com/ShahidHasib586/Driving-Range-Prediction).
