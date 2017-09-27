% This script creates cData, bigCell, and sData. cData and sData are the
% same data in different formats (cell versus structure arrays,
% respectively). bigCell is a quite large cell array to show the difficulty
% of working with cell arrays on some occassions. 
%
% The cData and sData variables will be used in future weeks to demonstrate
% selection statements, 

%% Generate Simple Recognition Memory Data using EVSD model using d' = 1, sd = 1, c = -.2
% Seed random number generator to make this reproducible
rng(84);

% Define parameters
dPrime = 1; % Mean of distribution for old item strengths
sd = 1; % Variance of distribution for old item strengths
c = -.2; % Response bias (decision) parameter, negative is more conservative
nTrials = 200; % Number of trials to simulate
rtHit.mean = 1.3; % Mean in Seconds for hits
rtHit.sd = .2; % SD in seconds for hits
rtMiss.mean = 1.6; % Mean in Seconds for misses
rtMiss.sd = .2; % SD in seconds for misses
rtFA.mean = 1.5; % Mean in seconds for false alarms
rtFA.sd = .2; % SD in seconds for false alarms
rtCR.mean = 1.1; % SD in seconds for correct rejections
rtCR.sd = .2; % SD in seconds for correct rejections

% Generate random samples for old and new items
oldValues = norminv(rand(nTrials,1),-dPrime,sd); % Make a nTrials X 1 column vector for old item memory strengths
newValues = norminv(rand(nTrials,1),0,sd); % % Make a nTrilas X 1 column vector for new item memory strengths

% Determine resposnes for old responses
oldResponses = ones(size(oldValues)); % Codes everything as 1 first
oldResponses(oldValues > c) = 2; % Change "new responses" to 2s using logical indexing. Thus, 1=Old resposne and 2=New Response
oldLabels = repmat({'old'},size(oldResponses)); % Get category label for old trials. Will be used later

% Determine resposnes for old responses
newResponses = ones(size(newValues)); % Codes everything as 1 first
newResponses(newValues > c) = 2; % Change "new responses" to 2s using logical indexing. Thus, 1=Old resposne and 2=New Response
newLabels = repmat({'new'},size(newResponses)); % Get category label for old trials. Will be used later

% Make random RT vectors for old Trials
oldRT = zeros(size(oldResponses));
oldRT(oldResponses == 1) = norminv(rand(sum(oldResponses == 1),1),rtHit.mean,rtHit.sd); % Use logical indexing to replace 0s with hit RTs
oldRT(oldResponses == 2) = norminv(rand(sum(oldResponses == 2),1),rtMiss.mean,rtMiss.sd); % Use logical indexing to replace 0s with miss RTs

% Make random RT vectors for new Trials
newRT = zeros(size(newResponses));
newRT(newResponses == 1) = norminv(rand(sum(newResponses == 1),1),rtFA.mean,rtFA.sd); % Use logical indexing to replace 0s with fa RTs
newRT(newResponses == 2) = norminv(rand(sum(newResponses == 2),1),rtCR.mean,rtCR.sd); % Use logical indexing to replace 0s with cr RTs

% Make cData
cData = horzcat( ...
    vertcat(oldLabels,newLabels), ...
    num2cell(vertcat(oldResponses,newResponses)), ...
    num2cell(vertcat(oldRT, newRT)) );
cData = cData(randperm(size(cData,1)),:); % Randomly sort rows in the cell array
cData = horzcat(num2cell(transpose(1:2*nTrials)),cData); % Add a trial number column to the left
cData = vertcat({'trial_num' 'item_type' 'resp' 'rt'},cData); % Add column headers

%% Convert cData to sData
% Get cData into a more workable format
myFields = cData(1,:); % Separate out header column
thisData = cData(2:end,:); % Separate data out 

% Make a single element structure variable with the fields
sData = struct();
for i = 1:length(thisData)
    for j = 1:length(myFields)
        sData(i).(myFields{j}) = thisData{i,j};
    end
end

%% Make the bigCell data
bigCell = cell(1000,2);
for i = 1:size(bigCell,1);
    bigCell{i,1} = sprintf('compant%04.0f',i);
    bigCell{i,2} = normrnd(100,1)*rand(1,10000);
end

%% Save it all
save('week2_data_file.mat','cData','sData','bigCell'); % Like load, after the file name specifies which variables to save. If none are provided. ALL Variables in the workspace are saved. 
   
        
