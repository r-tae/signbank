defmodule SignbankWeb.MapComponents do
  @moduledoc """
  Provides region maps inline SVGs.
  """
  use Phoenix.Component

  @doc """
  Renders a map of australia, takes a list of regions to highlight.
  """
  attr :class, :string, default: ""

  attr(:selected, :atom,
    values: [
      :australia_wide,
      :northern,
      :southern,
      :new_south_wales,
      :northern_territory,
      :queensland,
      :south_australia,
      :tasmania,
      :victoria,
      :western_australia
    ]
  )

  # TODO: bring up a modal with region names on click
  def australia_map(assigns) do
    selected =
      assigns.selected
      |> Enum.map(& &1.region)
      |> Enum.map_join(" ", fn
        :australia_wide -> "region_map_svg__select_aus"
        :northern -> "region_map_svg__select_nth"
        :southern -> "region_map_svg__select_sth"
        :new_south_wales -> "region_map_svg__select_nsw"
        :northern_territory -> "region_map_svg__select_nt"
        :queensland -> "region_map_svg__select_qld"
        :south_australia -> "region_map_svg__select_sa"
        :tasmania -> "region_map_svg__select_tas"
        :victoria -> "region_map_svg__select_vic"
        :western_australia -> "region_map_svg__select_wa"
      end)

    assigns = assign(assigns, selected: selected)

    # HACK: per convo with LW 2023-08-23, temporary measure to hide aus-wide maps
    ~H"""
    <svg
      :if={@selected != "region_map_svg__select_aus"}
      xmlns:svg="http://www.w3.org/2000/svg"
      xmlns="http://www.w3.org/2000/svg"
      version="1.0"
      width="100"
      height="93"
      viewBox="0 0 200 186"
      class={Enum.join([@class, "region_map_svg", @selected], " ")}
    >
      <g id="root" fill="#d3d3d3" stroke="black">
        <path
          id="NSW"
          d="M 199.1875,104.4375 C 198.83653,104.43081 198.34998,104.46425 198.0625,104.4375 C 197.31177,104.36764 196.77298,104.23444 196.34375,104.09375 C 195.48529,103.81238 195.10212,103.46104 194.5625,103.46875 C 193.71456,103.48021 193.37252,103.7504 193.1875,104 C 193.00248,104.2496 192.98169,104.49188 192.78125,104.46875 C 192.3825,104.42274 192.14493,104.58987 191.96875,104.875 C 191.79257,105.16013 191.69504,105.5619 191.5625,105.96875 C 191.42996,106.3756 191.26782,106.80584 191,107.125 C 190.73218,107.44416 190.33204,107.66545 189.75,107.6875 C 189.1067,107.71125 188.63102,107.50296 188.21875,107.1875 C 187.80648,106.87204 187.4631,106.42838 187.15625,106 C 186.8494,105.57162 186.57703,105.15876 186.25,104.84375 C 185.92297,104.52874 185.53532,104.3191 185.0625,104.34375 C 183.87838,104.40547 183.48532,104.16837 183.0625,103.90625 C 182.63968,103.64413 182.19488,103.375 181,103.375 C 180.39544,103.375 180.03006,103.50748 179.75,103.71875 C 179.46994,103.93002 179.28524,104.21381 179.0625,104.5 C 178.83976,104.78619 178.58886,105.05649 178.15625,105.28125 C 177.72364,105.50601 177.09715,105.69177 176.1875,105.71875 C 175.03771,105.75229 174.35678,105.40622 173.75,105.0625 C 173.14322,104.71878 172.61423,104.35834 171.8125,104.28125 C 162.86678,103.42108 141.32486,102.26983 138.625,102.125 L 137.03125,129.53125 C 137.54917,129.75192 138.56431,129.81254 139.625,129.96875 C 140.18125,130.05067 140.7364,130.16482 141.21875,130.34375 C 141.7011,130.52268 142.08885,130.77013 142.34375,131.125 C 142.64472,131.544 142.75321,132.43548 142.90625,133.15625 C 142.98277,133.51663 143.07146,133.83373 143.21875,134.03125 C 143.36604,134.22877 143.55385,134.31173 143.84375,134.1875 C 144.58118,133.87151 145.20772,133.73096 145.71875,133.75 C 146.22978,133.76904 146.62195,133.9476 146.90625,134.21875 C 147.19055,134.4899 147.38025,134.84091 147.4375,135.28125 C 147.49475,135.72159 147.42012,136.25463 147.25,136.78125 C 147.14001,137.12174 148.23355,138.26366 149.5625,139.46875 C 150.89145,140.67384 152.47624,141.93906 153.34375,142.4375 C 153.64326,142.60959 153.85198,142.60307 154.03125,142.53125 C 154.21052,142.45943 154.35851,142.30018 154.46875,142.125 C 154.68924,141.77463 154.81085,141.35808 155.0625,141.4375 C 155.63899,141.61945 156.09667,141.52701 156.46875,141.5 C 156.84083,141.47299 157.13028,141.52068 157.40625,141.96875 C 157.64888,142.36269 157.88431,142.56006 158.125,142.65625 C 158.36569,142.75244 158.61509,142.75307 158.84375,142.71875 C 159.07241,142.68443 159.29347,142.6226 159.5,142.625 C 159.70653,142.6274 159.88819,142.69988 160.0625,142.90625 C 160.26498,143.14597 160.64031,143.3045 161.0625,143.40625 C 161.48469,143.508 161.95643,143.5547 162.3125,143.5625 C 163.99682,143.59939 165.36951,143.29586 166.34375,143.34375 C 166.83087,143.36769 167.22712,143.47707 167.5,143.75 C 167.77288,144.02293 167.9346,144.47017 167.96875,145.15625 C 168.023,146.24621 168.41182,147.191 169.03125,148.03125 C 169.65068,148.8715 170.48262,149.60479 171.40625,150.28125 C 172.45463,151.04908 173.48117,151.69999 174.5625,152.375 C 174.8182,151.87258 175.08006,151.42329 175.375,150.8125 C 176.02844,149.4593 178.06166,145.28606 179.875,141.53125 C 181.68833,137.77643 184.94923,131.98884 187.9375,129.5 C 191.29853,126.7007 194.17919,122.69785 196.125,116.1875 C 197.73949,110.78569 198.72715,108.50415 199.1875,104.4375 z M 173.15625,139.5 C 173.49282,139.48654 173.83893,139.54187 174.15625,139.6875 C 174.42841,139.81241 174.5172,139.99038 174.5,140.1875 C 174.4828,140.38462 174.34449,140.60476 174.1875,140.84375 C 173.87351,141.32172 173.44461,141.8492 173.46875,142.3125 C 173.41231,142.56664 173.14933,143.11767 172.78125,143.1875 C 172.59721,143.22241 172.37325,143.13855 172.15625,142.84375 C 171.93925,142.54895 171.71999,142.03235 171.5,141.21875 C 171.3657,140.72206 171.52233,140.30047 171.84375,140 C 172.16517,139.69953 172.6514,139.5202 173.15625,139.5 z "
        />
        <path
          id="ACT"
          d="M 173.15625,139.5 C 173.49282,139.48654 173.83893,139.54187 174.15625,139.6875 C 174.42841,139.81241 174.5172,139.99038 174.5,140.1875 C 174.4828,140.38462 174.34449,140.60476 174.1875,140.84375 C 173.87351,141.32172 173.44461,141.8492 173.46875,142.3125 C 173.41231,142.56664 173.14933,143.11767 172.78125,143.1875 C 172.59721,143.22241 172.37325,143.13855 172.15625,142.84375 C 171.93925,142.54895 171.71999,142.03235 171.5,141.21875 C 171.3657,140.72206 171.52233,140.30047 171.84375,140 C 172.16517,139.69953 172.6514,139.5202 173.15625,139.5 z "
        />
        <path
          id="WA"
          d="M 81.34375,116.59375 L 80.09375,84.65625 L 80.09375,84.65625 L 77.6875,23.1875 C 77.650137,23.187993 77.632299,23.187635 77.59375,23.1875 C 73.296472,23.069469 67.140263,13.184428 63.3125,18.75 C 59.504317,24.287099 57.095867,17.962153 56.15625,26.0625 C 56.024926,27.194634 54.772933,26.53125 53.875,26.53125 C 52.667486,26.53125 51.386077,27.50511 53.21875,29.28125 C 54.599569,30.619475 53.239124,32.065249 51.90625,31.75 C 49.878126,31.270312 47.919146,32.362582 48.25,32.9375 C 50.40019,36.673835 51.04898,36.105091 49.375,37.21875 C 47.938402,38.174485 49.287386,41.02806 45.59375,32.5 C 45.131405,31.432512 40.756698,37.302049 41.28125,39.3125 C 41.68541,40.861521 42.817966,43.46875 42.375,43.46875 C 41.932034,43.468749 39.726622,43.420331 39.1875,46.59375 C 38.488799,50.70649 32.766607,54.375 29.40625,54.375 C 28.277331,54.375 27.109166,54.772906 26.8125,55.25 C 26.515834,55.727093 23.246293,57.681105 19.5625,59.21875 C 15.878706,60.756394 11.260809,61.718908 10.59375,63.6875 C 10.001486,65.435361 7.267423,66.014934 5.84375,67.625 C 3.939475,69.778592 3.2900965,72.476945 2.90625,69.71875 C 1.8264064,61.959352 1.1038508,71.150969 0.40625,73.40625 C -0.068993191,74.942671 2.0117668,77.109056 2,77.6875 C 1.9335602,80.953613 -1.8794139,83.268691 3.90625,87.71875 C 5.8392429,89.205517 7.8543327,92.775264 4.53125,95.09375 C 1.9091635,96.92316 7.8253797,99.121714 7.625,102.03125 C 7.5013423,103.82677 12.281122,107.60461 12.78125,108.8125 C 13.690418,111.00828 13.850005,115.86365 16.34375,118.25 C 18.641646,120.44893 19.548817,131.26856 18.6875,131.25 C 15.825447,131.18833 15.444226,137.15372 18.9375,136.25 C 20.876685,135.74833 21.349234,137.98662 22.28125,138.78125 C 24.745238,140.88202 33.342431,138.55156 34.75,135.9375 C 35.311816,134.89413 36.460954,134.46875 37.0625,134.46875 C 38.499967,134.46875 38.432385,132.98307 39,132.15625 C 39.277705,131.75173 40.935238,131.80781 42.65625,131.40625 C 44.315193,131.01916 46.042144,129.94093 46.625,130 C 47.768966,130.11593 48.697011,131.35085 49.84375,131.40625 C 50.499486,131.43794 54.192038,129.88418 55.46875,129.75 C 57.433679,129.54348 58.079857,127.08227 58.5,126 C 59.317407,123.89439 60.501,123.8897 62.84375,123.28125 C 65.949054,122.47477 65.851995,118.89374 72.25,119.875 C 74.419133,120.20768 77.364827,118.01936 78.6875,117.21875 C 79.194641,116.91178 80.186363,116.74344 81.34375,116.59375 z "
        />
        <path
          id="VIC"
          d="M 174.5625,152.375 C 173.48117,151.69999 172.45463,151.04908 171.40625,150.28125 C 170.48262,149.60479 169.65068,148.8715 169.03125,148.03125 C 168.41182,147.191 168.023,146.24621 167.96875,145.15625 C 167.9346,144.47017 167.77288,144.02293 167.5,143.75 C 167.22712,143.47707 166.83087,143.36769 166.34375,143.34375 C 165.36951,143.29586 163.99682,143.59939 162.3125,143.5625 C 161.95643,143.5547 161.48469,143.508 161.0625,143.40625 C 160.64031,143.3045 160.26498,143.14597 160.0625,142.90625 C 159.88819,142.69988 159.70653,142.6274 159.5,142.625 C 159.29347,142.6226 159.07241,142.68443 158.84375,142.71875 C 158.61509,142.75307 158.36569,142.75244 158.125,142.65625 C 157.88431,142.56006 157.64888,142.36269 157.40625,141.96875 C 157.13028,141.52068 156.84083,141.47299 156.46875,141.5 C 156.09667,141.52701 155.63899,141.61945 155.0625,141.4375 C 154.81085,141.35808 154.68924,141.77463 154.46875,142.125 C 154.35851,142.30018 154.21052,142.45943 154.03125,142.53125 C 153.85198,142.60307 153.64326,142.60959 153.34375,142.4375 C 152.47624,141.93906 150.89145,140.67384 149.5625,139.46875 C 148.23355,138.26366 147.14001,137.12174 147.25,136.78125 C 147.42012,136.25463 147.49475,135.72159 147.4375,135.28125 C 147.38025,134.84091 147.19055,134.4899 146.90625,134.21875 C 146.62195,133.9476 146.22978,133.76904 145.71875,133.75 C 145.20772,133.73096 144.58118,133.87151 143.84375,134.1875 C 143.55385,134.31173 143.36604,134.22877 143.21875,134.03125 C 143.07146,133.83373 142.98277,133.51663 142.90625,133.15625 C 142.75321,132.43548 142.64472,131.544 142.34375,131.125 C 142.08885,130.77013 141.7011,130.52268 141.21875,130.34375 C 140.7364,130.16482 140.18125,130.05067 139.625,129.96875 C 138.56431,129.81254 137.54917,129.75192 137.03125,129.53125 L 135.6875,152.25 C 136.02406,152.53882 136.25001,152.9014 136.25,153.21875 C 136.25,153.79972 137.27732,154.91695 139.09375,153.53125 C 139.87034,152.93881 141.27596,153.94319 143.3125,154.9375 C 146.39636,156.44315 147.36313,156.53541 149.03125,155.5 C 150.69119,154.46966 151.47218,154.5549 153.71875,155.90625 C 157.41953,160.03161 160.84932,158.56932 162.90625,156 C 163.93159,154.71924 167.35834,153.43344 169.78125,153.78125 C 173.16206,154.26658 174.01051,153.45957 174.5625,152.375 z "
        />
        <path
          id="QLD"
          d="M 153.09375,0.625 C 151.98009,0.71116902 149.60324,2.737831 149.625,5.65625 C 149.6381,7.4507695 148.04217,8.4921947 148.1875,10.3125 C 148.42656,13.306863 146.97179,12.749563 147.28125,14.25 C 147.87829,17.144708 146.09237,16.19749 145.9375,18.03125 C 145.83105,19.29176 146.42076,19.454842 146.53125,20.8125 C 147.04031,27.129232 143.78051,36.631373 139.1875,38.15625 C 138.36522,38.429246 137.05134,39.309116 134.875,37.5625 C 133.23989,36.250227 132.23052,34.164092 130.53125,33.59375 C 129.14152,33.127311 127.53339,32.273086 127.25,31.875 C 127.20142,31.806757 126.75759,31.5756 126.6875,31.5 L 124.625,85.25 L 139.625,85.46875 L 138.625,102.125 C 141.32486,102.26983 162.86678,103.42108 171.8125,104.28125 C 172.61423,104.35834 173.14322,104.71878 173.75,105.0625 C 174.35678,105.40622 175.03771,105.75229 176.1875,105.71875 C 177.09715,105.69177 177.72364,105.50601 178.15625,105.28125 C 178.58886,105.05649 178.83976,104.78619 179.0625,104.5 C 179.28524,104.21381 179.46994,103.93002 179.75,103.71875 C 180.03006,103.50748 180.39544,103.375 181,103.375 C 182.19488,103.375 182.63968,103.64413 183.0625,103.90625 C 183.48532,104.16837 183.87838,104.40547 185.0625,104.34375 C 185.53532,104.3191 185.92297,104.52874 186.25,104.84375 C 186.57703,105.15876 186.8494,105.57162 187.15625,106 C 187.4631,106.42838 187.80648,106.87204 188.21875,107.1875 C 188.63102,107.50296 189.1067,107.71125 189.75,107.6875 C 190.33204,107.66545 190.73218,107.44416 191,107.125 C 191.26782,106.80584 191.42996,106.3756 191.5625,105.96875 C 191.69504,105.5619 191.79257,105.16013 191.96875,104.875 C 192.14493,104.58987 192.3825,104.42274 192.78125,104.46875 C 192.98169,104.49188 193.00248,104.2496 193.1875,104 C 193.37252,103.7504 193.71456,103.48021 194.5625,103.46875 C 195.10212,103.46104 195.48529,103.81238 196.34375,104.09375 C 196.77298,104.23444 197.31177,104.36764 198.0625,104.4375 C 198.34998,104.46425 198.83653,104.43081 199.1875,104.4375 C 199.39112,102.6388 199.5,100.57291 199.5,97.59375 C 199.5,89.464417 199.40034,87.542632 198.25,86.59375 C 197.4331,85.919913 196.12707,84.93271 196.28125,83.25 C 196.34755,82.52622 195.31451,79.819883 193.125,78.5625 C 189.4512,76.452713 190.60429,74.281967 190.78125,73.21875 C 191.13615,71.086368 188.01975,67.843751 186.59375,67.84375 C 185.85865,67.843749 184.19338,72.582496 184.21875,64.65625 C 184.22343,63.179926 183.85474,62.198208 183.40625,61.875 C 182.53059,61.243945 182.08891,60.760039 182.125,60.21875 C 182.17114,59.526497 183.38418,58.797241 183.375,58.15625 C 183.35845,57.00133 181.29865,56.929958 180,55.78125 C 174.50908,50.924316 166.90096,49.044563 170.21875,45.78125 C 170.70298,45.304902 168.73509,44.625824 168.3125,43.5 C 168.01601,42.710159 171.84482,42.164183 167.90625,37.5 C 165.62099,34.793721 166.6539,26.979107 166.46875,26.125 C 166.04313,24.161608 163.78055,21.459727 162.53125,21.5 C 160.67178,21.559943 160.88599,22.948951 159.28125,22.625 C 158.09652,22.38584 157.78485,17.34652 157.46875,12.59375 C 157.49838,10.920962 155.83139,10.500918 156.09375,9.5 C 156.73882,7.0390959 154.92948,7.2579828 154.9375,6.5625 C 154.99003,2.0101845 154.72967,0.49842142 153.09375,0.625 z "
        />
        <path
          id="TAS"
          d="M 153.48868,183.29975 C 152.73743,182.40088 152.12645,180.1161 152.39992,176.82793 C 152.52943,175.27073 151.27114,174.15429 150.64074,172.97142 C 148.42197,168.80816 151.12927,167.02226 155.07525,169.76931 C 156.74221,170.92978 158.36558,170.95897 161.5036,170.53146 C 164.08932,170.17921 166.31008,170.26332 166.46323,170.97325 C 166.90276,173.01065 165.2328,171.45879 165.41307,175.07528 C 165.47143,176.24593 164.43423,177.77062 164.43775,178.60277 C 164.44401,180.12997 163.34639,180.8467 163.42191,181.6092 C 163.54702,182.87243 162.54823,184.16251 162.20631,184.16251 C 161.24646,184.16251 161.61718,180.9159 159.41272,184.1599 C 158.01826,186.21194 155.174,185.31623 153.48868,183.29975 z "
        />
        <g id="NT">
          <path
            id="NT-mainland"
            d="M 77.6875,23.1875 L 80.09375,84.65625 L 124.625,85.25 L 126.6875,31.5 C 126.34872,31.1346 126.02985,30.798945 123.96875,29.6875 C 122.84504,29.081537 110.41237,22.506512 113.4375,20.8125 C 117.49033,18.542997 115.39667,13.994132 117.375,13.3125 C 119.14675,12.702043 122.48408,8.7074617 121.625,7.28125 C 120.27165,6.3016183 118.39536,6.26625 117.71875,7.25 C 117.2877,7.876718 116.32472,7.7911127 115.9375,7.40625 C 115.76772,7.237504 114.92082,6.3159978 114.21875,6.15625 C 113.31958,5.9516578 112.43937,7.4458851 111.1875,6.4375 C 109.4475,5.035927 106.39149,6.603752 101.71875,3.6875 C 96.096913,0.17891536 94.218295,1.161452 95.53125,4.59375 C 96.638347,7.4879052 96.015955,7.7167742 92.15625,7.59375 C 87.669121,7.4507274 86.859536,7.2576632 84.40625,10.34375 C 82.53109,12.351574 83.260056,13.838232 83.0625,14.03125 C 78.306268,18.678257 82.115635,23.12911 77.6875,23.1875 z "
          />
          <path
            id="Groote-Eyland"
            d="M 122.16794,15.819607 C 121.95745,15.311193 119.81055,15.787198 119.13138,15.833157 C 118.3545,15.885729 117.86162,17.060638 118.05744,18.036737 C 118.3428,19.459183 120.1872,19.834585 120.41009,18.920037 C 120.60502,18.120236 120.83478,17.800713 121.22343,17.304492 C 121.34585,17.121172 122.31087,16.164849 122.16794,15.819607 z "
          />
          <path
            id="Melville-Island"
            d="M 91.533285,1.4725605 C 91.261672,0.26024852 89.113331,2.7579 87.493323,1.8509936 C 87.164378,1.6668453 85.508297,0.96600698 84.468782,2.5627617 C 83.756802,3.6564035 86.206623,5.5438684 88.022838,5.5499127 C 89.626637,5.5550324 89.920511,4.665705 90.18996,4.4508123 C 90.428744,4.2603753 92.155402,4.249309 91.533285,1.4725605 z "
          />
        </g>
        <g id="SA">
          <path
            id="SA-mainland"
            d="M 135.6875,152.25 L 137.03125,129.53125 C 137.03125,129.53125 137.03125,129.53125 137.03125,129.53125 L 138.625,102.125 C 138.625,102.125 138.625,102.125 138.625,102.125 L 139.625,85.46875 L 124.625,85.25 L 124.625,85.25 L 80.09375,84.65625 L 81.34375,116.59375 C 82.719716,116.41579 84.362272,116.27201 86.15625,116.0625 C 89.377613,115.6863 90.103338,113.2133 93.78125,116.0625 C 95.725608,117.56875 97.049318,117.30049 99.5,117.84375 C 101.21219,118.22331 105.13075,119.69202 105.875,120.65625 C 106.68451,121.70505 104.42413,121.52647 104.28125,122.53125 C 104.098,123.81992 105.47121,123.72448 106.53125,124 C 107.79709,124.32901 110.14299,126.13445 110.09375,129.03125 C 110.01314,133.77317 111.79843,134.96082 113.71875,133.78125 C 114.2142,133.4769 113.69579,131.49205 114.3125,130.75 C 114.74738,130.22674 116.84391,128.7085 118.75,127.03125 C 120.65608,125.35401 121.75814,122.95183 122.09375,123.21875 C 122.71046,123.70923 122.97314,126.63867 122.15625,127.3125 C 121.33935,127.98634 120.11005,129.47029 120.1875,130.375 C 119.94544,135.25928 117.0492,133.91439 118.53125,135 C 121.12884,136.90275 121.39368,134.08685 122,132.15625 C 122.40468,130.86769 123.33181,130.31742 123.84375,130.5625 C 124.78094,131.01118 125.89875,133.23079 125.1875,134.625 C 124.04334,136.8678 122.56325,138.35426 126,137.78125 C 128.73858,137.32464 130.15846,140.69337 130.1875,144.21875 C 130.21029,146.98404 133.06977,151.81251 134.6875,151.8125 C 135.05182,151.8125 135.40793,152.01009 135.6875,152.25 z "
          />
          <path
            id="Kangaroo-Island"
            d="M 121.49204,138.51327 C 121.46821,136.73665 115.63843,136.48647 115.69496,139.03747 C 115.71911,140.12728 121.51662,140.4077 121.49204,138.51327 z "
          />
        </g>
      </g>
    </svg>
    """
  end
end