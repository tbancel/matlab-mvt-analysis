function data=read_csv_data(file_name)

% function reading the information contained in the file .csv called file_name
% the information are summed up in a structure data which fields are : noms
% containing the names of the markers, coord: matrix of the coordinates of
% the markers

disp('... reading csv data');
fid=fopen(file_name,'r');
if isempty(file_name)|fid==-1
    FICH.noms=0;
    FICH.coord=0;
    FICH.actmec=0;
else
    % mise du compteur a 1 et acquisition de la premiere ligne
    compt=1;
    ligne=fgetl(fid);
    % detection de la ligne contenant les noms de marqueurs (debute par une
    % virgule)
    while isempty(strfind(ligne,'TRAJECTORIES'))
        ligne=fgetl(fid);
    end;
    ligne_frequence=fgetl(fid);
    sep=',';
    if ~isempty(strfind(ligne_frequence,';'))
        sep=';'   ;
    end
    %   strfind(ligne_frequence,'sep')
    emplacement_virgule = strfind(ligne_frequence,sep);
    FICH.freq = str2num(ligne_frequence(1:emplacement_virgule-1));
    ligne_noms=fgetl(fid);
    % extraction des noms des marqueurs et creation d'un tableau contenant ces
    % noms
    FICH.noms=extraire_noms(ligne_noms);

    for ttt=1:length(FICH.noms);
        if strfind(FICH.noms{ttt},':')
            emp=strfind(FICH.noms{ttt},':');
            FICH.noms{ttt}= FICH.noms{ttt}(emp+1:end) ;
        end
    end

    ligne=fgetl(fid);
    % creation de la matrice de coordonnees FICH.coord jusqu'a rencontrer une
    % ligne vide
    ligne=fgetl(fid);
    while ~feof(fid) & ~isempty(ligne)
        if ~isempty(str2num(ligne))
            %  emp_sep=strfind(ligne,';')
            FICH.coord(compt,:)=str2num(ligne);
        end
        compt=compt+1;
        ligne=fgetl(fid);
    end;
    aqui=FICH.coord(:,1);
    FICH.coord=FICH.coord(:,2:size(FICH.coord,2));

    % On doit maintenant déterminer si des mesures analogiques (EMG ont été
    % réalisée)
    % Pour cela, on saute puis on compare le titre avec ANALOG ou FORCE PLATES
    % Si on trouve analog on recupere la matrice d'EMG et des plateaux (qui la
    % suit) sinon on recupere la matrice des plateaux
    ligne = fgetl(fid);

    if ~isempty(strfind(ligne,'ANALOG'))
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % CAS AVEC EMG et FORCE PLATES
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        compt =1;
        % acquisition de la matrice EMG

        ligne_frequence = fgetl(fid);
        % stockage de la frequence

        emplacement_virgule = strfind(ligne_frequence,sep);
        frequence_plateau = str2num(ligne_frequence(1:emplacement_virgule-1));
        % recupération de la matrice EMG - on saute 2 lignes (label et unités)
        ligne = fgetl(fid);
        ligne = fgetl(fid);
        ligne = fgetl(fid);
        while ~feof(fid) & ~isempty(ligne)
            FICH.EMG(compt,:)=str2num(ligne);
            compt=compt+1;
            ligne=fgetl(fid);
        end;
        FICH.EMG = FICH.EMG(:,2:end);

        % Lorsque on acquiert l'EMG, la fréquence d'acquisition des entrees
        % analogiques (plate forme et EMG) est plus élevée que la fréquence d'acquisition des caméras
        % Il faut que la matrice des actions mécaniques ait la meme taille que la
        % matrice des coordonnées donc il faut éliminer un certain nombre de lignes
        % Pour cela on calcule l'intervalle entre les lignes que l'on conserve
        intervalle =frequence_plateau/ FICH.freq;
        compt=1;
        ligne=fgetl(fid);

        %% modif pour TImone
        while isempty(ligne) | ~strncmp(ligne,'Plate#',5)
            ligne=fgetl(fid);
        end;

        loc=1;
        ligne=fgetl(fid);
        while~isempty(str2num(ligne))
            FICH.corner(loc,:)=str2num(ligne) ;
            ligne=fgetl(fid);
            loc=loc+1
        end
        %% fin de modif pour timone
        while isempty(ligne) | ~strncmp(ligne,'Units',5)
            ligne=fgetl(fid);
        end;
        ligne=fgetl(fid);
        while ~feof(fid) & ~isempty(ligne) & compt<=size(FICH.coord,1)
            ligne=strrep(ligne,',,,,',',NaN,NaN,NaN,');



            FICH.actmec(compt,:)=str2num(ligne);
            compt=compt+1;
            for j = 1:intervalle
                ligne=fgetl(fid);
            end;
        end
        FICH.actmec=FICH.actmec(:,2:size(FICH.actmec,2));
        % fermeture du fichier
    elseif ~isempty(strfind(ligne,'FORCE PLATES'))

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % CAS AVEC PLATEAU DE FORCE SANS EMG
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        FICH.EMG =[];
        compt=1;
        ligne=fgetl(fid);
        emplacement_virgule = strfind(ligne,sep);
        frequence_plateau = str2num(ligne(1:emplacement_virgule-1));
        intervalle = frequence_plateau/FICH.freq;
        while isempty(ligne) | ~strncmp(ligne,'Units',5)
            ligne=fgetl(fid);
        end;
        ligne=fgetl(fid);
        while ~feof(fid) & ~isempty(ligne) & compt<=size(FICH.coord,1)
            if ~isempty(str2num(ligne))
                FICH.actmec(compt,:)=str2num(ligne);
            end
            compt=compt+1;
            for j = 1:intervalle
                ligne=fgetl(fid);
            end;
        end
        FICH.actmec=FICH.actmec(:,2:size(FICH.actmec,2));
    else
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % CAS SANS PLATEAU DE FORCE NI EMG
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        FICH.EMG =[];
        FICH.freq = 50;
        FICH.actmec = [];
    end;
    fclose(fid);
end;

if size(FICH.actmec,1)<size(FICH.coord,1)
    FICH.actmec(end+1,:)=NaN;
end

data=FICH;

