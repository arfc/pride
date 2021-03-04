import numpy as np
import pandas as pd
from data_parser import get_output_files, make_reactor_plots


if __name__ == "__main__":
    output = get_output_files()
    make_reactor_plots(output, True)
