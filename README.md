# Elite:Dangerous Passenger Mission Helper

Quick'n'Dirty tool to find "profitable" star systems.  In general it sounds
like, you find system with station far, far away from Hyperjump exit point. Now
there's another system nearby, that may offer high-paying Passenger mission to
that station.  Problem is - these systems are boring to find, you need to click
a lot of links on <https://eddb.io/>.

To make life *a bit* easier I made this simple script.  You download
`systems_populated.jsonl` and `stations.jsonl` from <https://eddb.io/api>,
import data to your local database (yes, you need access to PostgreSQL database,
by default script connects to database `ed` on local socket as current user)
and then do whatever search you like.

Requires:

* Ruby
* Bundler
* PostgreSQL

Simple usage (after git clone):

    $ bundle install
    $ bundle exec bin/edpmh init
    $ bundle exec bin/edpmh import .../systems_populated.jsonl .../stations.jsonl
    <... takes some time ...>
    $ bundle exec bin/edpmh search
    <... Road to riches ...>

Advanced usage:

    # bundle exec bin/edpmh search --help
    ...
    COMMAND OPTIONS
        -2, --[no-]two-way        - Only search 2-way systems (source system selected from target list)
        -D, --ref-system-dist=arg - Max distance to reference system (default: none)
        -P, --min-population=arg  - Minimum source population (default: none)
        -R, --ref-system-id=arg   - Reference system ID (default: none)
        --[no-]ignore-planetary   - Ignore planetary destinations (default: enabled)
        -m, --max-jump=arg        - Maximum jump distance (default: 15)
        --max-dist=arg            - Maximum distance to station (default: 1000000000)
        --max-sources=arg         - Maximum number of source systems per target (default: none)
        --[no-]medium-pad         - Allow medium pad for source
        --min-dist=arg            - Minimum distance to station (default: 400000)

Search command have two stages.  First it finds all possible "targes" - systems
that have exactly one [non-planetary] station between `max-dist` and `min-dist` Ls
with at least L-sized landing pad and optionally are not farther than
`ref-system-dist` Lys from "reference system" `ref-system-id`.  Next, for
each "target" is searchs "sources" - systems that are no farther than
`max-jump` Lys and optionally having `min-population` population.
All found pairs are printed on standard output.

Not all information from EDDB data is imported. Not all imported information is
displayed of used in searches, so if you have anythng to add - patches are welcome.

o7

P.S. BTW, docs/ folder containd copy-pasted Combat Outfitting Guide made by
redditor [/u/HoochCow](https://www.reddit.com/user/HoochCow).
