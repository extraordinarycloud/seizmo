function [snr]=quicksnr(data,nwin,swin)
%QUICKSNR    Quick estimation of SNR for SEIZMO records
%
%    Description: QUICKSNR(DATA,NOISEWINDOW,SIGNALWINDOW) estimates the
%     signal to noise ratio for SEIZMO records by calculating the ratio of
%     the maximum-minimum amplitudes of two data windows that represent the
%     'noise' and the 'signal'.  NOISEWINDOW & SIGNALWINDOW need to be 2
%     element numeric arrays that specify the start and end of the window
%     relative to the records reference time.
%
%    Notes:
%
%    Tested on: Matlab r2007b
%
%    Usage:    snr=quicksnr(data,noisewindow,signalwindow)
%
%    Examples:
%     To get SNR estimates of P (assuming times are stored in header):
%       Ptimes=getarrival(data,'P');
%       snr=quicksnr(data,Ptimes+[-100 -20],Ptimes+[-20 40])
%
%    See also: getarrival, cut

%     Version History:
%        Jan. 28, 2008 - initial version
%        Feb. 23, 2008 - bug fix (was nsr)
%        Feb. 29, 2008 - SEISCHK support
%        Mar.  4, 2008 - doc update
%        Nov. 24, 2008 - doc update, history fix, input changed so that the
%                        windows are relative to the record reference time,
%                        better checks, formula changed to compare
%                        variation of values in the windows rather than
%                        just the maximums
%
%     Written by Garrett Euler (ggeuler at wustl dot edu)
%     Last Updated Nov.  24, 2008 at 00:30 GMT

% todo:

% check nargin
error(nargchk(3,3,nargin))

% check data structure
error(seizmocheck(data,'dep'))

% turn off struct checking
oldseizmocheckstate=get_seizmocheck_state;
set_seizmocheck_state(false);

% check headers
data=checkheader(data);

% turn off header checking
oldcheckheaderstate=get_checkheader_state;
set_checkheader_state(false);

% check windows
if(~isnumeric(nwin) || ~isnumeric(swin)...
        || numel(nwin)~=2 || numel(swin)~=2)
    error('seizmo:quicksnr:badInput',...
        'NOISEWINDOW & SIGNALWINDOW must be 2 element numeric arrays!');
end

% snr=(max-min of signal)/(max-min of noise)
[nmax,nmin]=getheader(cut(data,nwin(1),nwin(2)),'depmax','depmin');
[smax,smin]=getheader(cut(data,swin(1),swin(2)),'depmax','depmin');
snr=(smax-smin)./(nmax-nmin);

% toggle checking back
set_seizmocheck_state(oldseizmocheckstate);
set_checkheader_state(oldcheckheaderstate);

end
