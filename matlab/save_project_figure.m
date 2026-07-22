function save_project_figure(figureHandle, outputDirectory, fileName)
%%
%% Figure Export Helper:
%%
%{
Creates the output folder when required and exports a figure at 300 dpi, so every analysis writes result
files through one consistent path.

Input:

    figureHandle, outputDirectory, fileName
%}

if ~isfolder(outputDirectory)
    mkdir(outputDirectory);
end
exportgraphics(figureHandle, fullfile(outputDirectory, fileName), 'Resolution', 300);
end
