function [data]=subtractrecords(varargin)
%SUBTRACTRECORDS    Subtract SEIZMO records
%
%    Description: SUBTRACTRECORDS(DATA) will subtract records 2+ from
%     record 1 in DATA, returning one record with its header fields set to
%     those of the first record.  The header can be set to that of the last
%     record by setting option 'newhdr' to TRUE.  Records should be of the
%     same filetype, be evenly sampled, have the same sample rate, number
%     of points, and timing but these can all be ignored (for better or for
%     worse) by setting options available in BINOPERR to 'ignore'.
%     
%     SUBTRACTRECORDS(DATA1,DATA2) will subtract the records in DATA2 from
%     DATA1.  If either DATA1 or DATA2 are a single record the record will
%     be applied to every record of the other dataset.  DATA1 and DATA2
%     must contain the same number of records otherwise.
%     
%     SUBTRACTRECORDS(DATA1,DATA2,...,DATAN) subtracts records in datasets
%     2-N from those in dataset 1.  Every dataset must have the same number
%     of records.  The exception to this rule is single record datasets,
%     which are replicated to match the size of the rest of the datasets.
%     
%     SUBTRACTRECORDS(...,'newhdr',true) controls the inheritance of header
%     fields and will set the resultant records' header fields to those of
%     the last record to be subtracted.  So
%                    SUBTRACTRECORDS(DATA1,DATA2,'newhdr',true)
%     will produce records with header fields set to those in DATA2.  By
%     default 'newhdr' is set to FALSE which sets the resultant records'
%     header fields to those in DATA1.  If subtracting all records in a
%     single dataset, setting 'newhdr' to TRUE will set the resultant
%     record's header equal to the last record's header.  Leaving
%     'newhdr' set to the default FALSE will set the resultant record's
%     header to that of the first record's header.
%     
%     
%     The following options may also be controlled by BINOPERR.
%     
%     SUBTRACTRECORDS(...,'npts','error|warn|ignore') sets the reaction to
%     records with different numbers of points.  If the option is set to
%     'warn' or 'ignore', the number of points in the resultant records
%     will be equal to that of the shortest record.  Note that points are
%     operated on according to their order in the record not by their
%     timing, such that the first points are always operated on together
%     and so on.  By default 'npts' is set to 'error'.
%     
%     SUBTRACTRECORDS(...,'delta','error|warn|ignore') sets the reaction to
%     records with different sample rates.  If the option is set to 'warn'
%     or 'ignore', the records are just operated on point for point
%     (basically ignoring timing).  The resultant records' sample rates are
%     determined by the parent of their header fields (set by option
%     'newhdr').  By default 'delta' is set to 'error'.
%     
%     SUBTRACTRECORDS(...,'begin','error|warn|ignore') sets the reaction to
%     records with different begin times.  If the option is set to 'warn'
%     or 'ignore', the resultant records' begin times are determined by the
%     parent of their header fields (set by option 'newhdr').  By default
%     'begin' is set to 'warn'.
%     
%     SUBTRACTRECORDS(...,'ref','error|warn|ignore') sets the reaction to
%     records with different reference times.  If the option is set to
%     'warn' or 'ignore', the resultant records' reference times are
%     determined by the parent of their header fields (set by option
%     'newhdr').  By default 'ref' is set to 'warn'.
%     
%     SUBTRACTRECORDS(...,'ncmp','error|warn|ignore') sets the reaction to
%     records with different numbers of components.  If the option is set
%     to 'warn' or 'ignore', the number of components in the resultant
%     records will be equal to that of the record with the least.  Note
%     that components are operated on according to their order in the
%     record so that the first components always go together.  By default
%     'ncmp' is set to 'error'.
%     
%     SUBTRACTRECORDS(...,'leven','error|warn|ignore') sets the reaction to
%     unevenly sampled records.  If the option is set to 'warn' or
%     'ignore', the records are just operated on point for point (basically
%     ignoring timing).  The resultant records' leven fields are determined
%     by the parent of their header fields (set by option 'newhdr').  By
%     default 'leven' is set to 'error'.
%     
%     SUBTRACTRECORDS(...,'iftype','error|warn|ignore') sets the reaction
%     to records of different types.  If the option is set to 'warn' or
%     'ignore', the records are just operated on point for point.  The 
%     resultant records' iftypes are determined by the parent of their
%     header fields (set by option 'newhdr').  By default 'iftype' is set
%     to 'error'.
%     
%    Notes:
%     - Ampl-Phase spectral records are first converted to Real-Imag to
%       assure the operation is linear and equal to that on Real-Imag
%       records.  If you want to workaround this, convert the Ampl-Phase
%       records to General X vs Y.
%     
%    Tested on: Matlab r2007b
%     
%    Header changes: DEPMIN, DEPMAX, DEPMEN,
%     NPTS, E, NCMP (see option 'npts' and 'ncmp')
%     See option 'newhdr' for inheritance of other header fields.
%     
%    Usage:    data=subtractrecords(data)
%              data=subtractrecords(data1,data2)
%              data=subtractrecords(data1,data2,...,dataN)
%              data=subtractrecords(...,'newhdr',true|false)
%              data=subtractrecords(...,'npts','error'|'warn'|'ignore')
%              data=subtractrecords(...,'delta','error'|'warn'|'ignore')
%              data=subtractrecords(...,'begin','error'|'warn'|'ignore')
%              data=subtractrecords(...,'ref','error'|'warn'|'ignore')
%              data=subtractrecords(...,'ncmp','error'|'warn'|'ignore')
%              data=subtractrecords(...,'leven','error'|'warn'|'ignore')
%              data=subtractrecords(...,'iftype','error'|'warn'|'ignore')
%     
%    Examples:
%     Check if two records are exactly the same:
%      plot1(subtractrecords(data(1:2)))
%     
%    See also: addrecords, multiplyrecords, dividerecords, binoperr

%     Version History:
%        June 10, 2008 - initial version
%        June 11, 2008 - full filetype and class support
%        June 20, 2008 - doc update, 'ncmp' option
%        Oct.  6, 2008 - doc update, code clean, more checks, added example
%                        fixed amph2rlim handling, .dep and .ind rather 
%                        than .x and .t
%        Nov. 23, 2008 - now just calls RECORDFUN
%
%     Written by Garrett Euler (ggeuler at wustl dot edu)
%     Last Updated Nov. 23, 2008 at 20:45 GMT

% todo:

% pass on to recordfun
data=recordfun('-',varargin);

end
