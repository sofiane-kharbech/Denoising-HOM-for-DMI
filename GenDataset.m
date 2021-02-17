
% 1) This file generates a dataset of HOS for a given set of digital
% modulations and a transmission configuration

% 2) The generated dataset, named 'mat_HOS', is 3D: dimension one represents the HOS (a HOS vector),
% dimension two represents the HOS vector index as a sample, and dimension tree represents the antennas

% 3) If 'rng shuffle' is not available, use the following.
% clk=clock;
% RandStream.setGlobalStream(RandStream('mt19937ar','Seed',str2num(strrep(num2str(clk(4:6)),' ',''))*1e3))

% 4) If parallel processing is not enabled automatically, use the
% following.
% parpool('local',3)
% If you're working on Linux, maybe you need first to run the following.
% ! sudo chmod -R 777 /home/user_name/.matlab/local_cluster_jobs/R2017a
% R2017a is the Matlab folder,
% and if you don't have the required toolbox for parallel processing, you
% have to replace 'parfor' of the deepest loop with 'for'

% 5) After run termination, save the workspace. All the variables are needed
% to generate results using 'DetectionResults.m' 


rng shuffle

clc
clear

%--------------------------------------------> Parameters

Nt = 2;    % # of transmit antennas
Nr = 6;    % # of receive antennas
K = 4000;  % # of transmitted MIMO symbols
% K = 1100;

M = [1 2 3 4 5 6]; % pool of the possible modulations, cf. 'f_HOS_Extraction.m' for the names
% M = [1 2 3];

SNR = -2:1:15;     % signal-to-noise ratio in dB

lMC = 2000;        % Monte Carlo (MC) simulations

eestd = 0;         % The standard deviation of the error of noise power estimation

cfo = 0;           % Carrier frequency offset
% cfo = 1e-4;

phznoise = 0;      % Phase noise
% phznoise = comm.PhaseNoise('Level',-3,'FrequencyOffset',2e-3,'SampleRate',1);

%--------------------------------------------> Main processing

mat_HOS = [];

for cptSNR=1:length(SNR)

    for cptM=1:length(M)
        
        Pb_ee = eestd*randn(1,lMC);
        parfor cptMC=1:lMC
                
            HOS = f_HOS_Extraction(M(cptM),SNR(cptSNR),K,Nt,Nr,Pb_ee(cptMC),cfo,phznoise);
            mat_HOS = [mat_HOS; permute(HOS,[3 2 1])];
                
        end
   
        disp(['M = ' num2str(M(cptM)) ' completed.'])
            
    end
end

mat_HOS = permute(mat_HOS,[2 1 3]);

clearvars -except M SNR Nt Nr lMC mat_HOS
