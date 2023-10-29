from sys import argv 
import numpy as np

QUERY_NUMBER = 22
REFRESH_NUMBER = 2  

def filter_power_test(filename:str) -> (np.ndarray, np.ndarray):
    """
    Filters log file resulting from power test and returns the query times and refresh times

    Parameters
    ----------
    filename : str
        The path of the log file

    Returns
    -------
    query_times : np.ndarray
        The completion times of each query

    refresh_times : np.ndarray
        The completion times of each refresh operation
    """

    query_times = np.zeros(QUERY_NUMBER) # init time array
    refresh_times = np.array([]) # init refresh time array

    # read log file
    log_file = open(filename, "r")
    log = log_file.readlines()
    for line in log:

        # get each query time
        if "completed in" in line:
            line_split = line.split(" ")
            query_number = int(line_split[2])
            query_time = float(line_split[5])
            query_times[query_number-1] = query_time

        # get each refresh time
        if "refresh complete" in line:
            refresh_times = np.append(refresh_times, float(line.split(" ")[6]))

    return query_times, refresh_times

def filter_throughput_test(filename:str) -> float:
    """
    Filters log file resulting from throughput test and returns the total time and geometric mean

    Parameters
    ----------
    filename : str
        The path of the log file

    Returns
    -------
    total_time : float
        The total time of the throughput test

    geometric_mean : float
        The geometric mean of the query times

    """

    total_time = 0.0

    # read log file
    log_file = open(filename, "r")
    log = log_file.readlines()
    for line in log:

        # get each query time
        if "completed in" in line:
            total_time += float(line.split(" ")[5])
        
        # get geometric mean of query times
        if "Geometric mean" in line:
            geometric_mean = float(line.split(" ")[10])

    total_time = np.round(total_time, 2) # round total time to 2 decimal places, TPC-H 5.3.6.2 

    return total_time, geometric_mean

def calculate_qpchh(geometric_mean:float, refresh_times:np.ndarray, total_time:float, scale_factor:int, query_streams:int) -> float:
    """
    Calculates the QPCHH metric

    Parameters
    ----------
    geometric_mean : float
        The geometric mean of the query times during the throughput test

    refresh_times : np.ndarray
        The completion times of each refresh operation during the power test

    total_time : float
        The total time of the throughput test

    scale_factor : int
        The scale factor of the database

    query_streams : int
        The number of parallel access to the database

    Returns
    -------
    qpchh : float
        The QPCHH metric value
    """

    # prod_qi = np.prod(query_times)  # product of query times QI(i,s), TPC-H 5.3.7.2
    prod_qi = geometric_mean
    prod_ri = np.prod(refresh_times) # product of refresh times RI(j,s), TPC-H 5.3.7.3

    power_size = (3600 * scale_factor) / np.power(prod_qi * prod_ri, 1/24)  # TPC-H 5.4.1.1
    throughput_size = (query_streams * 22 * 3600) / (total_time * scale_factor) # TPC-H 5.4.2.1

    qpchh = np.sqrt(power_size * throughput_size) # TPC-H 5.4.3.1

    return qpchh

if __name__ == "__main__":
    if len(argv) < 3:
        print("Usage: qpchh <power test log> <throughput test log> [scale factor] [query streams]")
        exit(1)

    scale_factor = int(argv[3]) if len(argv) == 4 else 1
    query_streams = int(argv[4]) if len(argv) == 5 else 2
    
    query_times, refresh_times = filter_power_test(argv[1])
    total_time, geometric_mean = filter_throughput_test(argv[2])

    print(f"Scale factor: {scale_factor}")
    print(f"Total time: {total_time}")
    print(f"Geometric mean: {geometric_mean}")
    print(f"Query times: {query_times}")
    print(f"Refresh times: {refresh_times}")

    qpchh = calculate_qpchh(geometric_mean, refresh_times, total_time, scale_factor, query_streams)

    print(f"QPCHH: {qpchh}")