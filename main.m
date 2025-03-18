clc;
clearvars;
warning off;

%% ========================================================================
%  MATLAB Script: Feature Extraction from .mat Files
%  Author: Ali Maghami
%  Date: [2025-03-19]
%  Institution: Politecnico di Bari, Italy, TU Berlin, Germany
%  Description:
%      This script reads `.mat` files, extracts key features (time, force, 
%      displacement, and Tabor parameter μ), and performs preprocessing 
%      including interpolation and filtering. The processed data is saved 
%      as .mat and .csv files for further analysis.
%
%  Inputs:
%      - .mat files stored in a specified directory
%      - Required fields: 'inputs', 'viscoresults', and associated subfields
%
%  Outputs:
%      - Processed `.mat` files
%      - CSV files for use in external models
%      - Visualization plots (force, displacement, time)
%
% ========================================================================

% Define save file names
saved_data_collection_file = 'saved_data_collection.mat';
saved_finalist_file = 'saved_finalist.mat';

% Check if previously processed data exists
if exist(saved_data_collection_file, 'file')
    fprintf('Loading saved data collection from %s...\n', saved_data_collection_file);
    load(saved_data_collection_file, 'data_collection', 'max_length');
else
    % Define folder paths dynamically
    folderPaths = 'C:\\Users\\Utente\\OneDrive - Politecnico di Bari\\MATLAB FILES\\DIRMEG codes\\AP_codes4\\Results_7inputs';

    % Initialize variables
    max_length = 0;
    data_collection = {};

    % Process files in the folder
    folder = folderPaths;
    matFiles = dir(fullfile(folder, '*.mat'));

    for i = 1:length(matFiles)
        filename = fullfile(folder, matFiles(i).name);
        fprintf('Processing file: %s\n', filename);

        % Load the .mat file
        try
            data = load(filename);
        catch
            fprintf('Skipping file %s (Load Error)\n', filename);
            continue;
        end

        % Check required fields
        if isfield(data, 'inputs') && isfield(data.inputs, 'mu') && ...
                isfield(data.inputs, 'k') && isfield(data.inputs, 'n') && ...
                isfield(data, 'viscoresults') && isfield(data.inputs, 'param') && ...
                isfield(data.inputs.param, 'time') && ...
                isfield(data.viscoresults, 'alphavect') && ...
                isfield(data.viscoresults, 'Wvect') && ...
                isfield(data.inputs, 'prot') && isfield(data.inputs.prot, 'runload')

            % Extract vectors and clean NaN values
            alpha_values = data.viscoresults.alphavect(:);
            W_values = data.viscoresults.Wvect(:);
            time_values = data.inputs.param.time(:);
            mu = data.inputs.mu;

            % Extract intervals
            inter1 = data.inputs.intervals1;
            inter2 = data.inputs.intervals2;
            inter3 = data.inputs.intervals3;
            intervals = [inter1, inter2, inter3];

            % Remove NaN values
            non_nan_alpha = alpha_values(~isnan(alpha_values));
            non_nan_W_values = W_values(~isnan(W_values));
            non_nan_time = time_values(~isnan(time_values));

            % Skip if data is empty
            if isempty(non_nan_alpha) || isempty(non_nan_W_values)
                fprintf('Skipping file %s (Empty Data)\n', filename);
                continue;
            end

            % Ensure vector lengths match
            len = min([length(non_nan_time), length(non_nan_alpha)]);
            len2 = length(non_nan_W_values);

            time_values = non_nan_time(1:len);
            alpha_values = non_nan_alpha(1:len);
            W_values = non_nan_W_values(1:len2);

            % Update max length
            max_length = max(max_length, len);

            % Store extracted data
            data_collection{end+1} = {time_values, alpha_values, W_values, intervals, mu};
        else
            fprintf('Skipping file %s (Missing Fields)\n', filename);
        end
    end

    % Save data collection
    save(saved_data_collection_file, 'data_collection', 'max_length');
    fprintf('Data collection saved to %s\n', saved_data_collection_file);
end

% Stop execution if no valid data is found
if isempty(data_collection)
    fprintf('No valid data found!\n');
    return;
end

% Processing and saving the final dataset follows here...

