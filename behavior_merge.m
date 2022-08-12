%%
% author: manu

%%
close all; clear;

%%
opts.dirs_img_in = ... 
{ ... 
'/media/manu/samsung/behavior_detection_based/raw_1/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_2/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_3/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_4/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_5/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_6/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_7/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_8/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_9/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_10/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_11/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_12/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_13/imgs' ...
'/media/manu/samsung/behavior_detection_based/raw_14/imgs' ...
};
opts.dir_xml_out = '/media/manu/samsung/behavior_detection_based/raw_1-14/xmls';

dir_xml_out = opts.dir_xml_out;
dir_img_out = strrep(dir_xml_out, 'xmls', 'imgs');

system(sprintf('rm %s -rvf', dir_xml_out));
system(sprintf('rm %s -rvf', dir_img_out));
mkdir(dir_xml_out);
mkdir(dir_img_out);

idx = 0;

%%
for i = 1 : length(opts.dirs_img_in)
    dir_img_in = opts.dirs_img_in{i};
    dir_xml_in = strrep(dir_img_in, 'imgs', 'xmls_bs_plus');
    
    list_img  = struct2cell(dir(fullfile(dir_img_in, '*.jpg')))';
    paths_img = fullfile(dir_img_in, list_img(:, 1));
    
    fprintf('processing %d/%d dir %s with %d imgs\n', ...
        i, length(opts.dirs_img_in), dir_img_in, length(paths_img));
    
    for j = 1 : length(paths_img) 
        path_img = paths_img{j};
        [~, name, ~] = fileparts(path_img);
        path_xml = fullfile(dir_xml_in, [name '.xml']);
        
        % copy img anyway
        copyfile(path_img, fullfile(dir_img_out, [num2str(idx), '_r1-14.jpg']));
        idx = idx + 1;
        
        % skip missing xmls
        if ~exist(path_xml, 'file'), continue; end
        
        fid = fopen(path_xml);
        fseek(fid, 0, 'eof');
        fsize = ftell(fid);
        fclose(fid);

        % skip empty xmls
        if fsize == 0, continue; end
        
        copyfile(path_xml, fullfile(dir_xml_out, [num2str(idx-1), '_r1-14.xml']));
    end
end

fprintf('total number of image --> %d !!!\n', idx);

%%