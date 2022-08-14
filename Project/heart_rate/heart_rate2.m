
classdef Heart < matlab.apps.AppBase

% Properties that correspond to app components
properties (Access = public)
    UIFigure               matlab.ui.Figure   % UIFigure
    Image_2                matlab.ui.control.Image    % Image
    YourBPMEditField       matlab.ui.control.NumericEditField   % YourBPMEditField
    YourBPMEditFieldLabel  matlab.ui.control.Label  % YourBPMEditFieldLabel
    Image2                 matlab.ui.control.Image   % Image2
    Image                  matlab.ui.control.Image   % Image
    Button                 matlab.ui.control.Button  % Button
    UIAxes2                matlab.ui.control.UIAxes  % UIAxes2
    UIAxes                 matlab.ui.control.UIAxes  % UIAxes
end

% Callbacks that handle component events
methods (Access = private)
    % This method is called when the Button is released
    % Button pushed function: Button
    function ButtonPushed(app, event)
        % This this will prompt the user to select a file to open and then will choose type of file to open either a .wav or .mp3 fileor a .mp4 file
        [fileName, pathName] = uigetfile({'*.mp4;*.mp3;*.wav;'},'Select a video');
        if ~isequal(fileName,0)
            % This will  openth the file and then will play the file using Video Reader funcction 
            processed_video =  VideoReader(fullfile(pathName,fileName)); 

            % This will take the Height and width of the video and then will set the size of the axes to the size of the video
            vidHeight= processed_video.Height;
            vidWidth = processed_video.Width;
            % The number of channels in the video
            nChannels = 3;
        
            framerate = processed_video.FrameRate; % The framerate of the video

            len = processed_video.NumFrames; % The number of frames in the video



            % This will create a matrix of the size of the video and then will
            % read the video into the matrix
            Heart_data_type= struct('cdata', zeros(vidHeight, ...
                vidWidth, nChannels, 'uint8'), 'colormap', []);


            
            T = 1/framerate;  % The time between each frame
            tlen = len/framerate; % The length of the video in seconds
            t1 = linspace(0, tlen, len); % The time vector for the video



            f = -framerate/2:framerate/len:framerate/2-framerate/len;
            mov(1:len) = struct('cdata', zeros(vidHeight, vidWidth, ...
                nChannels, 'uint8'), 'colormap', []); % Preallocate movie structure.

            app.Button.Text = 'Processing...'; % Change the text of the button to Processing...
            % Put text on top of icon
            app.Button.IconAlignment = 'bottom'; % Align the text to the bottom of the icon
            
            
            % Create waitbar with same color as button
            wbar = permute(repmat(app.Button.BackgroundColor,15,1,200),[1,3,2]);
            % Black frame around waitbar
            wbar([1,end],:,:) = 0; 
            wbar(:,[1,end],:) = 0;
            % Load the empty waitbar to the button
            app.Button.Icon = wbar;
       
            % Grab all the frames and put into our struct
            for k = 1 : len
                mov(k).cdata = read(processed_video, k);
            end

            % Find the center 5th to average
          
            centerVerMin = ceil((vidHeight/5) ...
                + (vidHeight/5));  % The minimum vertical center point


            centerVerMax = ceil((vidHeight/5) ...
                + (vidHeight/5) + (vidHeight/5)); % The maximum vertical center point

            centerHorMin = ceil((vidWidth/5) ...
                + (vidWidth/5)); % The minimum horizontal center point


            centerHorMax = ceil((vidWidth/5)  ...
                + (vidWidth/5) +  + (vidWidth/5)); % The maximum horizontal center point

            sampleHor = centerHorMax - centerHorMin; % The horizontal sample size
            sampleVer = centerVerMax - centerVerMin; % The vertical sample size

            sample = zeros(sampleVer, sampleHor, len); % Preallocate sample matrix


            t = zeros(len); % Preallocate time vector
            avg = zeros(len);  % Preallocate average vector

            for k = 1 : len

               currentProg = min(round((size(wbar,2)-2)*(k/len)), ...
                   size(wbar,2)-2); % Current progress of the waitbar


                RGB = app.Button.Icon; % Get the current icon
                RGB(2:end-1, 2:currentProg+1, 1) = 0.6350  ; % Change the red channel
                RGB(2:end-1, 2:currentProg+1, 2) = 0.0780 ;  % Change the green channel
                RGB(2:end-1, 2:currentProg+1, 3) = 0.1840;   % Change the blue channel
                app.Button.Icon = RGB; % Update the icon
                
                % Pause to slow down animation
                pause(.3) 
                for j = centerHorMin : centerHorMax
                    for i = centerVerMin : centerVerMax
                        sampleHorIndex = j - centerHorMin + 1;
                        sampleVerIndex = i - centerVerMin + 1;
                        sample(sampleVerIndex, ...
                            sampleHorIndex, k) = ...
                            mov(k).cdata(i, j, 1);
                    end
                end
                t(k) = k;   % value of k (frames) for graphing
                avg(k) = mean(mean(sample(:,:,k)));
            

            end

             % remove waitbar
            app.Button.Icon = ''; 
            % Change button name
            app.Button.Text = 'Browse';

            Y = fftshift(fft(avg)); % FFT of the average
            plot(app.UIAxes,t,avg ,'LineWidth',2 ,'Color', '#eb4939'); % Plot the average
            

            title(app.UIAxes,['{\bf Mangitude of Frequency' ...
                ' to find Heart Rate }'], 'color', ...
                '#92b9e4','FontSize', ...
                14,'FontName' ...
                ,'TimeNewRoman'); grid on % Title the graph

            xlabel(app.UIAxes,'Frame', 'color', '#ff5d8e' ...
                ,'FontSize', ...
                14,'FontName' ...
                ,'TimeNewRoman'); % Label the x axis


            ylabel(app.UIAxes,'Pixel intensity', ...
                'color', '#ff5d8e','FontSize', ...
                14,'FontName' ...
                ,'TimeNewRoman'); % Label the y axis

            axis(app.UIAxes, 'auto') % Set the axis to auto scale


              yo=1/len*abs(Y) ; % Magnitude of the FFT
             
            stem(app.UIAxes2,f,yo,'filled', ...
                'LineWidth',2 ,'Color', '#eb4939'); % Plot the FFT



            title(app.UIAxes2,['{\bf Mangitude of ' ...
                'Frequency to find Heart Rate }'], 'color', ...
                '#92b9e4','FontSize', ...
                14,'FontName' ...
                ,'TimeNewRoman'); grid on  % Title the graph



            xlabel(app.UIAxes2,'Frequency (Hz)', ...
                'color', '#ff5d8e','FontSize', ...
                14,'FontName','TimeNewRoman'); % Label the x axis


            ylabel(app.UIAxes2,'Magnitude', 'color', ...
                '#ff5d8e','FontSize', ...
                14,'FontName' ...
                ,'TimeNewRoman'); % Label the y axis




            axis(app.UIAxes2, 'tight') % Set the axis to tight scale
            
            
            r1=max(real(yo), [], 'all'); % Find the maximum of the real part of the FFT
            app.YourBPMEditField.Value=r1; % Display the BPM

          

             
            
        end
    end
end

% Component initialization
methods (Access = private)

    % Create UIFigure and components
    function createComponents(app)

        % Get the file path for locating images
        pathToMLAPP = fileparts(mfilename('fullpath'));

        % Create UIFigure and hide until all components are created
        app.UIFigure = uifigure('Visible', 'off'); % Create the figure
        app.UIFigure.Color = [0.1255 0.1412 0.1569];  % Set the background color
        colormap(app.UIFigure, 'cool');  % Set the colormap to cool
        app.UIFigure.Position = [100 100 1120 808]; % Set the figure size
        app.UIFigure.Name = 'MATLAB App'; % Set the figure name

        % Create UIAxes
        app.UIAxes = uiaxes(app.UIFigure); % Create the axes
        xlabel(app.UIAxes, 'Frame') % Label the x axis
        ylabel(app.UIAxes, 'Pixel insitisy ') % Label the y axis
        zlabel(app.UIAxes, 'Z') % Label the z axis
        app.UIAxes.FontName = 'Times New Roman'; % Set the font name
        app.UIAxes.XColor = [1 1 1]; % Set the x axis color
        app.UIAxes.YColor = [1 1 1]; % Set the y axis color
        app.UIAxes.ZColor = [1 1 1]; % Set the z axis color
        app.UIAxes.Color = 'none'; % Set the axes color to none
        app.UIAxes.FontSize = 14; % Set the font sizek
        app.UIAxes.GridColor = [0.15 0.15 0.15];  % Set the grid color
        colormap(app.UIAxes, 'cool') % Set the colormap to cool
        app.UIAxes.Position = [12 219 516 385]; % Set the axes position

        % Create UIAxes2
        app.UIAxes2 = uiaxes(app.UIFigure); % Create the axes
        xlabel(app.UIAxes2, 'Frequency(Hz)') % Label the x axis
        ylabel(app.UIAxes2, 'Magnitude') % Label the y axis
        zlabel(app.UIAxes2, 'Z') % Label the z axis
        app.UIAxes2.FontName = 'Times New Roman'; % Set the font name
        app.UIAxes2.FontWeight = 'bold'; % Set the font weight
        app.UIAxes2.XColor = [1 1 1]; % Set the x axis color
        app.UIAxes2.YColor = [1 1 1]; % Set the y axis color
        app.UIAxes2.ZColor = [1 1 1]; % Set the z axis color
        app.UIAxes2.Color = 'none'; % Set the axes color to none
        app.UIAxes2.FontSize = 14; % Set the font sizek
        app.UIAxes2.MinorGridColor = [0.1 0.1 0.1];
        colormap(app.UIAxes2, 'cool')
        app.UIAxes2.Position = [592 226 484 378];

        % Create Button
        app.Button = uibutton(app.UIFigure, 'push');
        app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
        app.Button.HandleVisibility = 'callback';
        app.Button.Icon = fullfile(pathToMLAPP, 'Folder_opener.png');
        app.Button.IconAlignment = 'center';
        app.Button.BackgroundColor = [0.1255 0.1412 0.1569];
        app.Button.FontColor = [1 1 1];
        app.Button.Position = [446 75 230 82];
        app.Button.Text = '';

        % Create Image
        app.Image = uiimage(app.UIFigure);
        app.Image.Position = [197 630 311 168];
        app.Image.ImageSource = fullfile(pathToMLAPP, 'heartbeat_1_Regular.gif');

        % Create Image2
        app.Image2 = uiimage(app.UIFigure);
        app.Image2.Position = [480 645 114 139];
        app.Image2.ImageSource = fullfile(pathToMLAPP, 'main_logo.gif');

        % Create YourBPMEditFieldLabel
        app.YourBPMEditFieldLabel = uilabel(app.UIFigure);
        app.YourBPMEditFieldLabel.HorizontalAlignment = 'center';
        app.YourBPMEditFieldLabel.VerticalAlignment = 'top';
        app.YourBPMEditFieldLabel.FontName = 'Times New Roman';
        app.YourBPMEditFieldLabel.FontSize = 40;
        app.YourBPMEditFieldLabel.FontWeight = 'bold';
        app.YourBPMEditFieldLabel.FontColor = [1 1 1];
        app.YourBPMEditFieldLabel.Position = [135 174 188 53];
        app.YourBPMEditFieldLabel.Text = 'Your BPM';

        % Create YourBPMEditField
        app.YourBPMEditField = uieditfield(app.UIFigure, 'numeric');
        app.YourBPMEditField.HorizontalAlignment = 'center';
        app.YourBPMEditField.FontName = 'Times New Roman';
        app.YourBPMEditField.FontSize = 40;
        app.YourBPMEditField.FontColor = [1 1 1];
        app.YourBPMEditField.BackgroundColor = [0.1255 0.1412 0.1569];
        app.YourBPMEditField.Position = [111 51 234 106];

        % Create Image_2
        app.Image_2 = uiimage(app.UIFigure);
        app.Image_2.Position = [566 630 311 168];
        app.Image_2.ImageSource = fullfile(pathToMLAPP, 'heartpulse_inverese.gif');

        % Show the figure after all components are created
        app.UIFigure.Visible = 'on';
    end
end

% App creation and deletion
methods (Access = public)

    % Construct app
    function app = Heart

        % Create UIFigure and components
        createComponents(app)

        % Register the app with App Designer
        registerApp(app, app.UIFigure)

        if nargout == 0
            clear app
        end
    end

    % Code that executes before app deletion
    function delete(app)

        % Delete UIFigure when app is deleted
        delete(app.UIFigure)
    end
end
end