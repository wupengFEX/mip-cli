{%function name = handleConfig%}
    {%if $data && $data.conf && $data.config%}
        {%$confPath = $data.conf.ROOT_PATH|cat:'/conf/mip-require.config.json'%}
        {%if file_exists($confPath)%}
            {%$content = file_get_contents($confPath)%}
            {%if !empty($content)%}
                {%$data.config = json_decode($content)%}
            {%/if%}
        {%/if%}
    {%/if%}
    {%json_encode($data)%}
{%/function%}

{%function name = main%}
    {%handleConfig data=$data%}
{%/function%}
{%main data=$data%}