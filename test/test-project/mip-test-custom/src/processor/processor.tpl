{%function name = handleData%}
    {%$result=array()%}
    {%foreach $data as $key => $val%}
        {%if $key !== 'conf'%}
            {%$result[$key] = $val%}
        {%/if%}
    {%/foreach%}
    {%$data = $result%}

     {%*处理rcmd模板数据*%}
        {%$rcmd_list = []%}
        {%$rcmd_list_split = []%}
        {%$rcmd_index = ''%}
        {%$tem_index = ''%}
        {%foreach $data.template as $k => $v%}
            {%foreach $v as $index => $value%}
                {%if $value.rid == 'rec_research'%}
                    {%$rcmd_list = $value.tplData.list%}
                    {%$tem_index = $k%}
                    {%$rcmd_index = $index%}
                    {%break%}
                {%/if%}
            {%/foreach%}
        {%/foreach%}

        {%if $rcmd_list|@count > 0%}
            {%foreach $rcmd_list as $m => $n%}
                {%if $m is even%}
                    {%if $rcmd_list[$m+1]%}
                        {%$rcmd_list_split[] = [$rcmd_list[$m], $rcmd_list[$m+1]]%}
                    {%else%}
                        {%$rcmd_list_split[] = [$rcmd_list[$m]]%}
                    {%/if%}
                {%/if%}
            {%/foreach%}
            {%$data.template[$tem_index][$rcmd_index].tplData.list = $rcmd_list_split%}
        {%/if%}

    {%json_encode($data)%}
{%/function%}

{%function name = handleConfig%}
    {%if $data%}
        {%$data.config = null%}
        {%if $data.conf%}
            {%$confPath = $data.conf.ROOT_PATH|cat:'/conf/mip-require.config.json'%}
            {%if file_exists($confPath)%}
                {%$content = file_get_contents($confPath)%}
                {%if !empty($content)%}
                    {%$data.config = json_decode($content, true)%}
                {%/if%}
            {%/if%}
        {%/if%}
    {%/if%}
    {%handleData data=$data%}
{%/function%}

{%function name = main%}
    {%handleConfig data=$data%}
{%/function%}
{%main data=$data%}
