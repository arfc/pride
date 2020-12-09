from data_parser import make_capacity_plots, get_output_files


if __name__=="__main__":
    output = get_output_files()
    make_capacity_plots(output, True)
