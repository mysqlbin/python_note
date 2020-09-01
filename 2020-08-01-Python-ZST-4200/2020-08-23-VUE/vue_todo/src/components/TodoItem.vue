<template>
   <p>
       {{textcontent}}
    </p> 
</template>

<script>
export default {
    name: "TodoItem",
    props: {
        "textcontent": {
            default: 'no content',
            type: String
        }
    }
}
</script>