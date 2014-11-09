                    <div class="forms">
                        <h1>Perfil</h1>
                    </div>
                    <div class="profile">
                        <div class="photo">
                            <img src="{SITE_APP}/resources/images/profile/profile_avatar.png">        
                        </div>
                        <div class="containerText">
                            <div class="name">
                                <h2>{NAME}</h2>
                            </div>

                            <div class="email">
                                <h3>{EMAIL}</h3>
                            </div>
                        </div>
                        <div class="certsInfo">
                            <h3>Certificados</h3>
                            <div class="CSSTableGenerator" >
                                {TABLEUSERCERTS}
                            </div>
                        </div>
                    </div>
                            <script>
                                $("#main-table").oneSimpleTablePagination({rowsPerPage: 5});
                            </script>
