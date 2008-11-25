function [def]=seizmodef(filetype,version,option)
%SEIZMODEF    Returns specified SEIZMO definition structure
%
%    Description: [DEFINITIONS]=SEIZMODEF(FILETYPE,VERSION) returns the
%     struct DEFINITIONS which provides all formatting information
%     necessary to read/understand/modify/write the specified version
%     VERSION of the data filetype FILETYPE using the SEIZMO toolbox.
%
%     SEIZMODEF(FILETYPE,VERSION,OPTION) allows setting the caching
%     behavior with a logical.  If OPTION is set to TRUE, SEISMODEF will
%     first check if a cached definition struct exists for that filetype
%     and version and will use it.  If a definition does not exist, a new
%     one is created and cached.  OPTION set FALSE will always get a new
%     definition (updating the cache too).
%
%    Notes:
%     - Currently the definition is set so that all header data is stored 
%       as doubles in memory.  This attempts to preserve accuracy, provide
%       simplicity, and make class-issues a lot less of a headache. 
%       Memory usage suffers slightly (only minor as this applies to just
%       the header storage).  Breaking the header into subfields would
%       probably require more memory anyways due to overhead.
%
%    Tested on: Matlab r2007b
%
%    Usage:    definition=seizmodef(filetype,version)
%              definition=seizmodef(filetype,version,option)
%
%    Examples:
%     Get detailed information on SAC version 6 files:
%      sac_ver_6=seizmodef('SAC Binary',6)
%
%    See also:  seizmocheck, isseizmo, validseizmo

%     Version History:
%        Jan. 28, 2008 - initial version
%        Feb. 23, 2008 - rename to sachi, support for new versions
%        Feb. 28, 2008 - removed validity check (now vvseis)
%                        and renamed to seishi
%        Feb. 29, 2008 - header always stored in memory as double precision
%                        clean up of multi-component definition
%        Apr. 18, 2008 - removed versions for expanding npts/nspts
%        June 12, 2008 - renamed as seisdef and added example
%        June 23, 2008 - doc cleanup
%        Sep. 14, 2008 - minor doc update, input checks
%        Sep. 26, 2008 - multi-component indicator, minor code clean
%        Oct. 17, 2008 - filetype support (gonna break stuff)
%        Oct. 26, 2008 - minor doc update
%        Nov. 13, 2008 - renamed from SEISDEF to SEIZDEF
%        Nov. 15, 2008 - update for new name scheme (now SEIZMODEF), SAC
%                        and SEIZMO now separate filetypes, definition
%                        caching to speed things up
%        Nov. 24, 2008 - fixed iacc description (nm/sec/sec)
%
%     Written by Garrett Euler (ggeuler at wustl dot edu)
%     Last Updated Nov. 24, 2008 at 05:30 GMT

% todo:

% check input
error(nargchk(2,3,nargin))
if(~ischar(filetype))
    error('seizmo:seizmodef:badInput','FILETYPE must be a string!');
end
if(~isnumeric(version))
    error('seizmo:seizmodef:badInput','VERSION must be numeric!');
end
if(nargin==2 || isempty(option))
    option=true;
elseif(~islogical(option))
    error('seizmo:seizmodef:badInput',...
        'OPTION must be logical!')
end

% get valid versions
valid=validseizmo(filetype);

% check for invalid version
if(isempty(valid) || ~any(valid==version))
    error('seizmo:seizmodef:invalidVersion',...
        'Filetype: %s, Version: %d Invalid!',filetype,version)
end

% setup for global struct
ft=upper(filetype);
ft(isspace(ft))='_';
ver=['V' int2str(version)];

% reuse if already defined
global SEIZMO
if(option)
    try
        def=SEIZMO.SEIZMODEF.(ft).(ver);
        return;
    catch
        % goes on to create definition below
    end
end

% sac and seizmo binary setup
if(strcmpi(filetype,'SEIZMO Binary') || strcmpi(filetype,'SAC Binary'))
    % start with SAC version 6
    def.filetype='SAC Binary';
    def.version=6;
    def.numfields=133;
    def.size=302;
    def.store='double';
    
    def.data.startbyte=632;
    def.data.store='single';
    def.data.bytesize=4;
    
    def.mulcmp.valid=false;
    def.mulcmp.altver=101;
    
    def.types={'real' 'int' 'enum' 'lgc' 'char'};
    def.ntype={'real' 'int' 'enum' 'lgc'};
    def.stype={'char'};
    
    def.undef.stype='-12345';
    def.undef.ntype=-12345;
    
    def.true=1;
    def.false=0;
    
    def.grp.t.min=0;
    def.grp.t.max=9;
    def.grp.kt.min=0;
    def.grp.kt.max=9;
    def.grp.user.min=0;
    def.grp.user.max=9;
    def.grp.kuser.min=0;
    def.grp.kuser.max=2;
    def.grp.resp.min=0;
    def.grp.resp.max=9;
    
    def.real.startbyte=0;
    def.real.store='single';
    def.real.bytesize=4;
    def.real.numfields=70;
    def.real.size=70;
    def.real.minpos=1;
    def.real.maxpos=70;
    def.real.pos=struct('delta',1,'depmin',2,'depmax',3,'scale',4,...
        'odelta',5,'b',6,'e',7,'o',8,'a',9,'fmt',10,'t0',11,'t1',12,...
        't2',13,'t3',14,'t4',15,'t5',16,'t6',17,'t7',18,'t8',19,'t9',20,...
        'f',21,'resp0',22,'resp1',23,'resp2',24,'resp3',25, 'resp4',26,...
        'resp5',27,'resp6',28,'resp7',29,'resp8',30,'resp9',31,'stla',32,...
        'stlo',33,'stel',34,'stdp',35,'evla',36,'evlo',37,'evel',38,...
        'evdp',39,'mag',40,'user0',41,'user1',42,'user2',43,'user3',44,...
        'user4',45,'user5',46,'user6',47,'user7',48,'user8',49,'user9',50,...
        'dist',51,'az',52,'baz',53,'gcarc',54,'sb',55,'sdelta',56,...
        'depmen',57,'cmpaz',58,'cmpinc',59,'xminimum',60,'xmaximum',61,...
        'yminimum',62,'ymaximum',63,'unused6',64,'unused7',65,'unused8',66,...
        'unused9',67,'unused10',68,'unused11',69,'unused12',70);
    
    def.int.startbyte=280;
    def.int.store='int32';
    def.int.bytesize=4;
    def.int.numfields=15;
    def.int.size=15;
    def.int.minpos=71;
    def.int.maxpos=85;
    def.int.pos=struct('nzyear',71,...
        'nzjday',72,'nzhour',73,'nzmin',74,'nzsec',75,'nzmsec',76,...
        'nvhdr',77,'norid',78,'nevid',79,'npts',80,'nspts',81,'nwfid',82,...
        'nxsize',83,'nysize',84,'unused15',85);
    
    def.enum.startbyte=340;
    def.enum.store='int32';
    def.enum.bytesize=4;
    def.enum.numfields=20;
    def.enum.size=20;
    def.enum.minpos=86;
    def.enum.maxpos=105;
    def.enum.minval=0;
    def.enum.maxval=97;
    def.enum.pos=struct('iftype',86,'idep',87,'iztype',88,'unused16',89,...
        'iinst',90,'istreg',91,'ievreg',92,'ievtyp',93,'iqual',94,...
        'isynth',95,'imagtyp',96,'imagsrc',97,'unused19',98,'unused20',99,...
        'unused21',100,'unused22',101,'unused23',102,'unused24',103,...
        'unused25',104,'unused26',105);
    
    def.enum.id={'ireal' 'itime' 'irlim' 'iamph' 'ixy' 'iunkn' 'idisp' ...
        'ivel' 'iacc' 'ib' 'iday' 'io' 'ia' 'it0' 'it1' 'it2' ...
        'it3' 'it4' 'it5' 'it6' 'it7' 'it8' 'it9' 'iradnv' ...
        'itannv' 'iradev' 'itanev' 'inorth' 'ieast' 'ihorza' 'idown' ...
        'iup' 'illlbb' 'iwwsn1' 'iwwsn2' 'ihglp' 'isro' 'inucl' ...
        'ipren' 'ipostn' 'iquake' 'ipreq' 'ipostq' 'ichem' 'iother' ...
        'igood' 'iglch' 'idrop' 'ilowsn' 'irldta' 'ivolts' 'ixyz' ...
        'imb' 'ims' 'iml' 'imw' 'imd' 'imx' 'ineic' 'ipdeq' ...
        'ipdew' 'ipde' 'iisc' 'ireb' 'iusgs' 'ibrk' 'icaltech' ...
        'illnl' 'ievloc' 'ijsop' 'iuser' 'iunknown' 'iqb' 'iqb1' ...
        'iqb2' 'iqbx' 'iqmt' 'ieq' 'ieq1' 'ieq2' 'ime' 'iex' ...
        'inu' 'inc' 'io_' 'il' 'ir' 'it' 'iu' 'ieq3' 'ieq0' ...
        'iex0' 'iqc' 'iqb0' 'igey' 'ilit' 'imet' 'iodor'};
    
    def.enum.val=struct('ireal',0,'itime',1,'irlim',2,'iamph',3,'ixy',4,...
        'iunkn',5,'idisp',6,'ivel',7,'iacc',8,'ib',9,'iday',10,'io',11,...
        'ia',12,'it0',13,'it1',14,'it2',15,'it3',16,'it4',17,'it5',18,...
        'it6',19,'it7',20,'it8',21,'it9',22,'iradnv',23,'itannv',24,...
        'iradev',25,'itanev',26,'inorth',27,'ieast',28,'ihorza',29,...
        'idown',30,'iup',31,'illlbb',32,'iwwsn1',33,'iwwsn2',34,'ihglp',35,...
        'isro',36,'inucl',37,'ipren',38,'ipostn',39,'iquake',40,'ipreq',41,...
        'ipostq',42,'ichem',43,'iother',44,'igood',45,'iglch',46,...
        'idrop',47,'ilowsn',48,'irldta',49,'ivolts',50,'ixyz',51,'imb',52,...
        'ims',53,'iml',54,'imw',55,'imd',56,'imx',57,'ineic',58,'ipdeq',59,...
        'ipdew',60,'ipde',61,'iisc',62,'ireb',63,'iusgs',64,'ibrk',65,...
        'icaltech',66,'illnl',67,'ievloc',68,'ijsop',69,'iuser',70,...
        'iunknown',71,'iqb',72,'iqb1',73,'iqb2',74,'iqbx',75,'iqmt',76,...
        'ieq',77,'ieq1',78,'ieq2',79,'ime',80,'iex',81,'inu',82,'inc',83,...
        'io_',84,'il',85,'ir',86,'it',87,'iu',88,'ieq3',89,'ieq0',90,...
        'iex0',91,'iqc',92,'iqb0',93,'igey',94,'ilit',95,'imet',96,...
        'iodor',97);
    
    def.enum.desc={'Undocumented' ...
        ...% iftype
        'Time Series File' 'Spectral File-Real/Imag' ...
        'Spectral File-Ampl/Phase' 'General X vs Y file' ...
        ...% idep
        'Unknown' 'Displacement (nm)' ...
        'Velocity (nm/sec)' 'Acceleration (nm/sec/sec)' ...
        ...% iztype
        'Begin Time' 'GMT Day' 'Event Origin Time' 'First Arrival Time' ...
        'User Defined Time Pick 0' 'User Defined Time Pick 1' ...
        'User Defined Time Pick 2' 'User Defined Time Pick 3' ...
        'User Defined Time Pick 4' 'User Defined Time Pick 5' ...
        'User Defined Time Pick 6' 'User Defined Time Pick 7' ...
        'User Defined Time Pick 8' 'User Defined Time Pick 9' ...
        ...% iinst
        'Radial (NTS)' 'Tangential (NTS)' 'Radial (Event)' ... 
        'Tangential (Event)' 'North Positive' 'East Positive' ...
        'Horizontal (ARB)' 'Down Positive' 'Up Positive' ...
        'LLL Broadband' 'WWSN 15-100' 'WWSN 30-100' ...
        'High Gain Long Period' 'SRO' ...
        ...% ievtyp
        'Nuclear Event' 'Nuclear Pre-Shot Event' ...
        'Nuclear Post-Shot Event' 'Earthquake' 'Foreshock' ...
        'Aftershock' 'Chemical Explosion' 'Other' ...
        ...% iqual
        'Good' 'Glitches' 'Dropouts' 'Low Signal to Noise Ratio' ...
        ...% isynth
        'Real Data' ...
        ...% idep (cont)
        'Velocity (Volts)' ...
        ...% iftype (cont)
        'General XYZ (3-D) file' ...
        ...% imagtyp
        'Body Wave Magnitude (Mb)' 'Surface Wave Magnitude (Ms)' ...
        'Local Magnitude (ML)' 'Moment Magnitude (Mw)' ...
        'Duration Magnitude (Md)' 'User Defined Magnitude' ...
        ...% imagsrc
        'NEIC' 'PDEQ' 'PDEW' 'PDE' 'ISC' 'REB' 'USGS' 'Berkeley' ...
        'Caltech' 'LLNL' 'EVLOC' 'JSOP' 'User' 'Unknown' ...
        ...% ievtyp
        'Quarry/Mine Blast, Confirmed by Quarry' ... 
        'Quarry/Mine Blast with Shot Information, Ripple Fired' ... 
        'Quarry/Mine Blast with Observed Shot Information, Ripple Fired' ...
        'Quarry/Mine Blast, Single Shot' ...
        'Quarry or Mining Induced Events, Tremors and Rockbursts' ...
        'Earthquake' 'Earthquake, Swarm or Aftershock Sequence' ...
        'Earthquake, Felt' 'Marine Explosion' 'Other Explosion' ...
        'Nuclear Explosion' 'Nuclear Cavity Collapse' ...
        'Other Source, Known Origin' 'Local Event, Unknown Origin' ...
        'Regional Event, Unknown Origin' ...
        'Teleseismic Event, Unknown Origin' ...	
        'Undetermined or Conflicting Information' ...
        'Damaging Earthquake' 'Probable Earthquake' 'Probable Explosion' ...
        'Mine Collapse' 'Probable Mine Blast' 'Geyser' 'Light' ...
        'Meteroic Event' 'Odors'};
    
    def.lgc.startbyte=420;
    def.lgc.store='int32';
    def.lgc.bytesize=4;
    def.lgc.numfields=5;
    def.lgc.size=5;
    def.lgc.minpos=106;
    def.lgc.maxpos=110;
    def.lgc.pos=struct('leven',106,'lpspol',107,'lovrok',108,...
        'lcalda',109,'unused27',110);
    
    def.char.startbyte=440;
    def.char.store='char';
    def.char.bytesize=1;
    def.char.numfields=23;
    def.char.size=192;
    def.char.minpos=111;
    def.char.maxpos=302;
    def.char.pos=struct('kstnm',[111,118],'kevnm',[119,134],...
        'khole',[135,142],'ko',[143,150],'ka',[151,158],'kt0',[159,166],...
        'kt1',[167,174],'kt2',[175,182],'kt3',[183,190],'kt4',[191,198],...
        'kt5',[199,206],'kt6',[207,214],'kt7',[215,222],'kt8',[223,230],...
        'kt9',[231,238],'kf',[239,246],'kuser0',[247,254],...
        'kuser1',[255,262],'kuser2',[263,270],'kcmpnm',[271,278],...
        'knetwk',[279,286],'kdatrd',[287,294],'kinst',[295,302]);
end
 
% seizmo binary modifications
if(strcmpi(filetype,'SEIZMO Binary'))
    % seizmo version 101 mod (multi-component support)
    if(any(version==[101 201]))
        def.filetype='SEIZMO Binary';
        def.version=101;
        
        % turn on multi-component support indicator
        def.mulcmp.valid=true;
        def.mulcmp.altver=[];
        
        % replace unused15 with ncmp (number of dependent components)
        def.int.pos=rmfield(def.int.pos,'unused15');
        def.int.pos.ncmp=85;
    end
    
    
    % seizmo version 200 mod (double reals, double data)
    if(any(version==[200 201]))
        def.filetype='SEIZMO Binary';
        def.version=200;
        
        % split v6 'single' real group into 2 'double' real groups
        %def.real(1).startbyte=0;
        def.real(1).store='double';
        def.real(1).bytesize=8;
        def.real(1).numfields=35;
        def.real(1).size=35;
        %def.real(1).minpos=1;
        def.real(1).maxpos=35;
        def.real(1).pos=struct('delta',1,'depmin',2,'depmax',3,...
            'scale',4,'odelta',5,'b',6,'e',7,'o',8,'a',9,'fmt',10,'t0',11,...
            't1',12,'t2',13,'t3',14,'t4',15,'t5',16,'t6',17,'t7',18,...
            't8',19,'t9',20,'f',21,'resp0',22,'resp1',23,'resp2',24,...
            'resp3',25,'resp4',26,'resp5',27,'resp6',28,'resp7',29,...
            'resp8',30,'resp9',31,'stla',32,'stlo',33,'stel',34,'stdp',35);
        
        def.real(2).startbyte=440;
        def.real(2).store='double';
        def.real(2).bytesize=8;
        def.real(2).numfields=35;
        def.real(2).size=35;
        def.real(2).minpos=36;
        def.real(2).maxpos=70;
        def.real(2).pos=struct('evla',36,'evlo',37,'evel',38,'evdp',39,...
            'mag',40,'user0',41,'user1',42,'user2',43,'user3',44,...
            'user4',45,'user5',46,'user6',47,'user7',48,'user8',49,...
            'user9',50,'dist',51,'az',52,'baz',53,'gcarc',54,'sb',55,...
            'sdelta',56,'depmen',57,'cmpaz',58,'cmpinc',59,'xminimum',60,...
            'xmaximum',61,'yminimum',62,'ymaximum',63,'unused6',64,...
            'unused7',65,'unused8',66,'unused9',67,'unused10',68,...
            'unused11',69,'unused12',70);
        
        % push char/data out 280 (keep char at end following SAC layout)
        def.char.startbyte=720;
        def.data.startbyte=912;
        
        % change data storage
        def.data.store='double';
        def.data.bytesize=8;
    end
    
    % seizmo version 201 mod (101+200)
    if(any(version==201))
        def.version=201;
    end
end

% cache
SEIZMO.SEIZMODEF.(ft).(ver)=def;

end
